//
//  ParallaxImageView.swift
//  ParallaxScrollEffect
//
//  Created by 曾品瑞 on 2023/12/29.
//

import SwiftUI

struct ParallaxImageView<Content: View>: View {
    var full: Bool=false
    var move: CGFloat=100
    
    @ViewBuilder var content: (CGSize) -> Content
    
    var body: some View {
        GeometryReader {
            let height: CGFloat=$0.bounds(of: .scrollView)?.size.height ?? 0
            let minY: CGFloat=$0.frame(in: .scrollView(axis: .vertical)).minY
            let progress: CGFloat=minY/height
            let cap: CGFloat=max(min(progress, 1), -1)
            let size: CGSize=$0.size
            let move: CGFloat=min(self.move, size.height*0.35)
            let offset: CGFloat=cap * -move
            let stretch: CGSize=CGSize(width: size.width, height: size.height+move)
            
            self.content(size)
                .offset(y: offset)
                .frame(width: stretch.width, height: stretch.height)
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .containerRelativeFrame(self.full ? [.horizontal]:[])
    }
}
