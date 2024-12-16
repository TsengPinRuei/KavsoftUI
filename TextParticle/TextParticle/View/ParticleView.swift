//
//  ParticleView.swift
//  TextParticle
//
//  Created by Justin on 11/18/24.
//

import SwiftUI
import UIKit

func feedback() {
    let impact: UIImpactFeedbackGenerator=UIImpactFeedbackGenerator(style: .soft)
    impact.impactOccurred()
}

struct ParticleView: View {
    @State private var dragPosition: CGPoint?
    @State private var dragVelocity: CGSize?
    @State private var size: CGSize=CGSize.zero
    @State private var particles: [Particle]=[]
    
    let tint: Color
    let amount: Double
    let frame: Double
    let textSize: Double
    let text: String
    let power: Double
    private let timer=Timer.publish(every: 1/120, on: .main, in: .common).autoconnect()
    
    private func createParticles() {
        let renderer: ImageRenderer=ImageRenderer(
            content: Text(self.text).font(.system(size: self.textSize, weight: .bold, design: .rounded))
        )
        
        guard let image=renderer.uiImage else { return }
        guard let cgImage=image.cgImage else { return }
        guard let pixel=cgImage.dataProvider?.data, let data=CFDataGetBytePtr(pixel) else { return }
        
        let width: Int=Int(image.size.width)
        let height: Int=Int(image.size.height)
        let offsetX=(self.size.width-CGFloat(width))/2
        let offsetY=(self.size.height-CGFloat(height))/2
        
        
        self.particles=(0..<Int(self.amount)).map { _ in
            var x, y: Int
            
            repeat {
                x=Int.random(in: 0..<width)
                y=Int.random(in: 0..<height)
            } while data[((width*y)+x)*4+3]<128
            
            return Particle(
                x: Double.random(in: -self.size.width...self.size.width*2),
                y: Double.random(in: -self.size.height...self.size.height*2),
                baseX: Double(x)+offsetX,
                baseY: Double(y)+offsetY,
                density: Double.random(in: 10...20),
                power: self.power
            )
        }
    }
    private func updateParticles() {
        for i in self.particles.indices {
            self.particles[i].update(position: self.dragPosition, velocity: self.dragVelocity)
        }
    }
    
    var body: some View {
        Canvas { (context, size) in
            context.blendMode=GraphicsContext.BlendMode.normal
            
            for particle in self.particles {
                let path: Path=Path(ellipseIn: CGRect(x: particle.x, y: particle.y, width: self.frame, height: self.frame))
                context.fill(path, with: .color(self.tint))
            }
        }
        .background(.background)
        .overlay {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        self.size=proxy.size
                        self.createParticles()
                    }
            }
        }
        .onAppear {
            self.createParticles()
        }
        .onReceive(self.timer) { _ in
            self.updateParticles()
        }
        .onChange(of: self.text) {
            self.createParticles()
        }
        .onChange(of: self.textSize) {
            self.createParticles()
        }
        .onChange(of: self.amount) {
            self.createParticles()
        }
        .onChange(of: self.power) {
            self.createParticles()
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    self.dragPosition=value.location
                    self.dragVelocity=value.velocity
                    feedback()
                }
                .onEnded { value in
                    self.dragPosition=nil
                    self.dragVelocity=nil
                    self.updateParticles()
                }
        )
    }
}
