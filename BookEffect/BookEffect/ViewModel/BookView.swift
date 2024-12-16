//
//  BookView.swift
//  BookEffect
//
//  Created by 曾品瑞 on 2024/5/1.
//

import SwiftUI

struct BookView<Front: View, Left: View, Right: View>: View, Animatable {
    struct Configuration {
        var width: CGFloat=150
        var height: CGFloat=200
        var progress: CGFloat=0
        var corner: CGFloat=10
        var divider: Color=Color.white
        var shadow: Color=Color.black
    }
    
    var configuration: Configuration=Configuration()
    
    @ViewBuilder var front: (CGSize) -> Front
    @ViewBuilder var inLeft: (CGSize) -> Left
    @ViewBuilder var inRight: (CGSize) -> Right
    
    var animatableData: CGFloat {
        get { return self.configuration.progress }
        set { self.configuration.progress=newValue }
    }
    
    var body: some View {
        GeometryReader {
            let corner: CGFloat=self.configuration.corner
            let progress: CGFloat=max(min(self.configuration.progress, 1), 0)
            let rotation: CGFloat=progress * -180
            let shadow: Color=self.configuration.shadow
            let size: CGSize=$0.size
            
            ZStack {
                self.inRight(size)
                    .frame(width: size.width, height: size.height)
                    .clipShape(
                        .rect(
                            cornerRadii:
                                RectangleCornerRadii(
                                    topLeading: 0,
                                    bottomLeading: 0,
                                    bottomTrailing: corner,
                                    topTrailing: corner)
                        )
                    )
                    .shadow(color: shadow.opacity(0.1*progress), radius: 5, x: 5, y: 0)
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(self.configuration.divider.shadow(.inner(color: shadow.opacity(0.5), radius: 2)))
                            .frame(width: 5)
                            .clipped()
                    }
                
                self.front(size)
                    .frame(width: size.width, height: size.height)
                    .allowsHitTesting(-rotation<90)
                    .overlay {
                        if(-rotation>90) {
                            self.inLeft(size)
                                .frame(width: size.width, height: size.height)
                                .scaleEffect(x: -1)
                                .transition(.identity)
                        }
                    }
                    .clipShape(
                        .rect(
                            cornerRadii:
                                RectangleCornerRadii(
                                    topLeading: 0,
                                    bottomLeading: 0,
                                    bottomTrailing: corner,
                                    topTrailing: corner)
                        )
                    )
                    .shadow(color: shadow.opacity(0.1), radius: 5, x: 5, y: 0)
                    .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 0.3)
            }
            .offset(x: self.configuration.width/2*progress)
        }
        .frame(width: self.configuration.width, height: self.configuration.height)
    }
}
