//
//  ScratchView.swift
//  LotteryGeometryEffect
//
//  Created by 曾品瑞 on 2023/12/13.
//

import SwiftUI

struct ScratchView<Content: View, Overlay: View>: View {
    @State private var disableDrag: Bool=false
    @State private var scratch: Bool=false
    @State private var animate: [Bool]=[false, false]
    @State private var drag: [CGPoint]=[]
    
    var content: Content
    var overlay: Overlay
    var point: CGFloat
    var finish: () -> ()
    
    init(
        point: CGFloat,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder overlay: @escaping () -> Overlay,
        finish: @escaping () -> Void
    ) {
        self.content=content()
        self.overlay=overlay()
        self.point=point
        self.finish=finish
    }
    
    var body: some View {
        GeometryReader {reader in
            let size: CGSize=reader.size
            
            ZStack {
                self.overlay.opacity(self.disableDrag ? 0:1)
                
                self.content
                    .mask {
                        if(self.disableDrag) {
                            Rectangle()
                        } else {
                            PointShape(point: self.drag).stroke(style: StrokeStyle(lineWidth: self.scratch ? size.width*1.5:self.point, lineCap: .round, lineJoin: .round))
                        }
                    }
                    .gesture(
                        DragGesture(minimumDistance: self.disableDrag ? 100000:0)
                            .onChanged {value in
                                if(self.drag.isEmpty) {
                                    withAnimation(.smooth) {
                                        self.animate=[false, false]
                                    }
                                }
                                self.drag.append(value.location)
                            }
                            .onEnded {_ in
                                if(!self.drag.isEmpty) {
                                    withAnimation(.smooth(duration: 0.5), completionCriteria: .logicallyComplete) {
                                        self.scratch=true
                                    } completion: {
                                        withAnimation(.easeInOut) {
                                            self.disableDrag=true
                                        }
                                    }
                                    
                                    self.finish()
                                }
                            }
                    )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .rotation3DEffect(Angle(degrees: self.animate[0] ? 5:0), axis: (x: 1, y: 0, z: 0))
            .rotation3DEffect(Angle(degrees: self.animate[1] ? 5:0), axis: (x: 0, y: 1, z: 0))
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    self.animate[0]=true
                }
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true).delay(0.8)) {
                    self.animate[1]=true
                }
            }
        }
    }
}
