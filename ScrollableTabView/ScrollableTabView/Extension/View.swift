//
//  View.swift
//  ScrollableTabView
//
//  Created by 曾品瑞 on 2023/11/9.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minX=$0.frame(in: .scrollView(axis: .horizontal)).minX
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
    @ViewBuilder
    func tabMask(_ progress: CGFloat) -> some View {
        ZStack {
            self.foregroundStyle(.gray)
            
            self
                .symbolVariant(.fill)
                .mask {
                    GeometryReader {
                        let size=$0.size
                        let capsuleWidth=size.width/CGFloat(Tab.allCases.count)
                        
                        Capsule()
                            .frame(width: capsuleWidth)
                            .offset(x: progress*(size.width-capsuleWidth))
                    }
                }
        }
    }
}
