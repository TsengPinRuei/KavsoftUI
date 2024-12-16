//
//  DisintegrationEffect.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//


import SwiftUI

struct DisintegrationEffect: ViewModifier {
    @State private var animate: Bool=false
    @State private var snapshot: Bool=false
    @State private var particle: [Particle]=[]
    
    var delete: Bool
    var completion: () -> ()
    
    private func createParticle(_ snapshot: UIImage) async {
        let size: CGSize=snapshot.size
        let height: CGFloat=size.height
        let width: CGFloat=size.width
        var count: Int=1
        let maxCount: Int=1500
        var column: Int=Int(width)/count
        var row: Int=Int(height)/count
        var particles: [Particle]=[]
        
        while(row*column)>=maxCount {
            count+=1
            row=Int(height)/count
            column=Int(width)/count
        }
        
        for i in 0...row {
            for j in 0...column {
                let positionX: Int=j*count
                let positionY: Int=i*count
                let rect: CGRect=CGRect(x: positionX, y: positionY, width: count, height: count)
                let image: UIImage=self.cropImage(snapshot, rect: rect)
                
                particles.append(
                    Particle(
                        image: image,
                        offset: CGSize(width: positionX, height: positionY)
                    )
                )
            }
        }
        
        await MainActor.run { [particles] in
            self.particle=particles
            withAnimation(.smooth(duration: 2), completionCriteria: .logicallyComplete) {
                self.animate=true
            } completion: {
                self.completion()
            }
        }
    }
    private func cropImage(_ snapshot: UIImage, rect: CGRect) -> UIImage {
        let format: UIGraphicsImageRendererFormat=UIGraphicsImageRendererFormat()
        format.scale=1
        let renderer: UIGraphicsImageRenderer=UIGraphicsImageRenderer(size: rect.size, format: format)
        return renderer.image { context in
            context.cgContext.interpolationQuality=CGInterpolationQuality.low
            snapshot.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(self.particle.isEmpty ? 1:0)
            .overlay(alignment: .topLeading) {
                DisintegrationView(particle: self.$particle, animate: self.$animate)
            }
            .snapshot(shot: self.snapshot) { snapshot in
                Task.detached(priority: .high) {
                    try? await Task.sleep(for: .seconds(0.2))
                    await self.createParticle(snapshot)
                }
            }
            .onChange(of: self.delete) { (_, new) in
                if(new && self.particle.isEmpty) {
                    self.snapshot=true
                }
            }
    }
}
