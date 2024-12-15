//
//  HomeView.swift
//  InfiniteScrollView
//
//  Created by 曾品瑞 on 2023/11/28.
//

import SwiftUI

struct HomeView: View {
    @State private var width: CGFloat=150
    @State private var item: [Item]=[.red, .orange, .yellow, .green, .blue, .purple].compactMap { return Item(color: $0) }
    
    @ViewBuilder
    private func TitleView(title: String) -> some View {
        Text(title)
            .bold()
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
    }
    
    private func getAngle(proxy: GeometryProxy) -> Angle
    {
        let progress=proxy.frame(in: .global).minX/proxy.size.width
        let rotation: CGFloat=45
        return Angle(degrees: rotation*progress)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 50) {
                VStack(spacing: 0) {
                    self.TitleView(title: "Scrolling")
                    
                    LoopScrollView(width: self.width, spacing: 10, item: self.item) {item in
                        RoundedRectangle(cornerRadius: 10).fill(item.color.gradient)
                    }
                    .frame(height: 150)
                    .contentMargins(.horizontal, 15, for: .scrollContent)
                }
                
                VStack(spacing: 0) {
                    self.TitleView(title: "Paging")
                    
                    GeometryReader {
                        let size: CGSize=$0.size
                        
                        LoopScrollView(width: size.width, spacing: 0, item: self.item) {item in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(item.color.gradient)
                                .padding(.horizontal)
                        }
                        .scrollTargetBehavior(.paging)
                    }
                    .frame(height: 200)
                }
                
                VStack(spacing: 0) {
                    self.TitleView(title: "Instagram Effect")
                    
                    GeometryReader {
                        let size: CGSize=$0.size
                        
                        LoopScrollView(width: size.width, spacing: 0, item: self.item) {item in
                            GeometryReader {reader in
                                Rectangle()
                                    .fill(item.color.gradient)
                                    .rotation3DEffect(
                                        self.getAngle(proxy: reader),
                                        axis: (x: 0, y: 1, z: 0),
                                        anchor: reader.frame(in: .global).minX>0 ? .leading:.trailing,
                                        perspective: 2.5
                                    )
                            }
                        }
                        .scrollTargetBehavior(.paging)
                    }
                    .frame(height: 200)
                }
            }
            .padding(.vertical)
        }
        .scrollIndicators(.hidden)
    }
}
