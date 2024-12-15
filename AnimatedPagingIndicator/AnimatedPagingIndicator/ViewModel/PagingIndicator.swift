//
//  PagingIndicator.swift
//  AnimatedPagingIndicator
//
//  Created by 曾品瑞 on 2024/1/2.
//

import SwiftUI

struct PagingIndicator: View {
    var tint: Color=Color.primary
    var current: Color=Color.primary.opacity(0.2)
    var opacity: Bool=false
    var clip: Bool=false
    
    var body: some View {
        GeometryReader {
            let width: CGFloat=$0.size.width
            
            if let scrollWidth=$0.bounds(of: .scrollView(axis: .horizontal))?.width, scrollWidth>0 {
                let minX: CGFloat=$0.frame(in: .scrollView(axis: .horizontal)).minX
                let page: Int=Int(width/scrollWidth)
                let free: CGFloat = -minX/scrollWidth
                let clip: CGFloat=min(max(free, 0), CGFloat(page-1))
                let progress: CGFloat=self.clip ? clip:free
                let currentIndex: Int=Int(progress)
                let nextIndex: Int=Int(progress.rounded(.awayFromZero))
                let indicator: CGFloat=progress-CGFloat(currentIndex)
                let currentWidth: CGFloat=20-(indicator*20)
                let nextWidth: CGFloat=indicator*20
                
                HStack(spacing: 10) {
                    ForEach(0..<page, id: \.self) {index in
                        Capsule()
                            .fill(.clear)
                            .frame(width: 10+(currentIndex==index ? currentWidth:(nextIndex==index ? nextWidth:0)), height: 10)
                            .overlay {
                                ZStack {
                                    Capsule().fill(self.current)
                                    
                                    Capsule()
                                        .fill(self.tint)
                                        .opacity(self.opacity ? currentIndex==index ? 1-indicator:(nextIndex==index ? indicator:0):1)
                                }
                            }
                    }
                }
                .frame(width: scrollWidth)
                .offset(x: -minX)
            }
        }
        .frame(height: 30)
    }
}
