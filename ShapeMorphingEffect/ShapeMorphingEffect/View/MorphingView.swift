//
//  MorphingView.swift
//  ShapeMorphingEffect
//
//  Created by 曾品瑞 on 2024/10/8.
//

import SwiftUI

struct MorphingView: View {
    struct Configuration {
        var font: Font
        var foreground: Color
        var frame: CGSize
        var radius: CGFloat
        var duration: CGFloat=0.5
        var animation: Animation=Animation.smooth(duration: 0.5, extraBounce: 0)
    }
    
    @State private var animate: Bool=false
    @State private var current: String=""
    @State private var next: String=""
    
    var symbol: String
    var configuration: Configuration
    
    @ViewBuilder
    private func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: self.animate) {radius in
            Image(systemName: self.current=="" ? self.symbol:self.current)
                .font(self.configuration.font)
                .blur(radius: radius)
                .frame(width: self.configuration.frame.width, height: self.configuration.frame.height)
                .onChange(of: radius) {(_, new) in
                    if(new.rounded()==self.configuration.radius) {
                        withAnimation(self.configuration.animation) {
                            self.current=self.next
                        }
                    }
                }
        } keyframes: {_ in
            CubicKeyframe(self.configuration.radius, duration: self.configuration.duration)
            CubicKeyframe(0, duration: self.configuration.duration)
        }
    }
    
    var body: some View {
        Canvas {ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: self.configuration.foreground))
            
            if let symbol=ctx.resolveSymbol(id: 0) {
                ctx.draw(symbol, at: CGPoint(x: size.width/2, y: size.height/2))
            }
        } symbols: {
            self.ImageView().tag(0)
        }
        .frame(width: self.configuration.frame.width, height: self.configuration.frame.height)
        .onChange(of: self.symbol) {(_, new) in
            self.animate.toggle()
            self.next=new
        }
        .task {
            guard self.current=="" else { return }
            self.current=self.symbol
        }
    }
}
