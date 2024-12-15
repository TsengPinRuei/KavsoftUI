//
//  CoverFlowView.swift
//  CoverFlow
//
//  Created by 曾品瑞 on 2024/1/17.
//

import SwiftUI

struct CoverFlowView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    var width: CGFloat
    var spacing: CGFloat=0
    var reflection: Bool
    var rotation: Double
    var item: Item
    var content: (Item.Element) -> Content
    
    private func rotation(_ proxy: GeometryProxy) -> Double {
        let midX: CGFloat=proxy.frame(in: .scrollView(axis: .horizontal)).midX
        let width: CGFloat=proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let progress: CGFloat=midX/width
        let cap: CGFloat=max(min(progress, 1), 0)
        let rotation: CGFloat=max(min(self.rotation, 90), 0)
        let degree: CGFloat=cap*(rotation*2)
        return rotation-degree
    }
    
    var body: some View {
        GeometryReader {
            let size=$0.size
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(self.item) {item in
                        self.content(item)
                            .frame(width: self.width)
                            .reflection(self.reflection, count: 6)
                            .visualEffect {(content, proxy) in
                                content
                                    .rotation3DEffect(Angle(degrees: self.rotation(proxy)), axis: (x: 0, y: 1, z: 0), anchor: .center)
                            }
                            .padding(.trailing, item.id==self.item.last?.id ? 0:self.spacing)
                    }
                }
                .padding(.horizontal, (size.width-self.width)/2)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
        }
    }
}
