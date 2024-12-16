//
//  FlipEffect.swift
//  FlipTextEffect
//
//  Created by 曾品瑞 on 2024/6/2.
//

import SwiftUI

fileprivate struct FlipRotation: ViewModifier, Animatable {
    var size: CGSize
    var rotation: CGFloat
    var current: Int
    var next: Int
    var font: CGFloat
    var foreground: Color
    var animatableData: CGFloat {
        get { self.rotation }
        set { self.rotation=newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                Group {
                    if(-self.rotation>90) {
                        Text("\(self.next)")
                            .bold()
                            .font(.system(size: self.font))
                            .foregroundStyle(self.foreground)
                            .scaleEffect(x: 1, y: -1)
                            .transition(.identity)
                            .lineLimit(1)
                    } else {
                        Text("\(self.current)")
                            .bold()
                            .font(.system(size: self.font))
                            .foregroundStyle(self.foreground)
                            .transition(.identity)
                            .lineLimit(1)
                    }
                }
                .frame(width: size.width, height: size.height)
                .drawingGroup()
            }
    }
}

struct FlipEffect: View {
    @Binding var value: Int
    
    @State private var rotation: CGFloat=0
    @State private var current: Int=0
    @State private var next: Int=0
    
    var size: CGSize
    var font: CGFloat
    var radius: CGFloat
    var foreground: Color
    var background: Color
    var duration: CGFloat
    
    @ViewBuilder
    private func TextView(_ value: Int) -> some View {
        Text("\(value)")
            .bold()
            .font(.system(size: self.font))
            .foregroundStyle(self.foreground)
            .lineLimit(1)
    }
    
    var body: some View {
        let height: CGFloat=self.size.height*0.5
        ZStack {
            UnevenRoundedRectangle(
                topLeadingRadius: self.radius,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: self.radius
            )
            .fill(self.background.shadow(.inner(radius: 1)))
            .frame(height: height)
            .overlay(alignment: .top) {
                self.TextView(self.next)
                    .frame(width: self.size.width, height: self.size.height)
                    .drawingGroup()
            }
            .clipped()
            .frame(maxHeight: .infinity, alignment: .top)
            
            UnevenRoundedRectangle(
                topLeadingRadius: self.radius,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: self.radius
            )
            .fill(self.background.shadow(.inner(radius: 1)))
            .frame(height: height)
            .modifier(
                FlipRotation(
                    size: self.size,
                    rotation: self.rotation,
                    current: self.current,
                    next: self.next,
                    font: self.font,
                    foreground: self.foreground
                )
            )
            .clipped()
            .rotation3DEffect(
                Angle(degrees: self.rotation),
                axis: (x: 1, y: 0, z: 0),
                anchor: .bottom,
                anchorZ: 0,
                perspective: 0.5
            )
            .frame(maxHeight: .infinity, alignment: .top)
            .zIndex(1)
            
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: self.radius,
                bottomTrailingRadius: self.radius,
                topTrailingRadius: 0
            )
            .fill(self.background.shadow(.inner(radius: 1)))
            .frame(height: height)
            .overlay(alignment: .bottom) {
                self.TextView(self.current)
                    .frame(width: self.size.width, height: self.size.height)
                    .drawingGroup()
            }
            .clipped()
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(width: self.size.width, height: self.size.height)
        .onChange(of: self.value) {(old, new) in
            self.current=old
            self.next=new
            
            guard self.rotation==0 else {
                self.current=new
                return
            }
            guard old != new else { return }
            
            withAnimation(.easeInOut(duration: self.duration), completionCriteria: .logicallyComplete) {
                self.rotation = -180
            } completion: {
                self.rotation=0
                self.current=self.value
            }
        }
    }
}
