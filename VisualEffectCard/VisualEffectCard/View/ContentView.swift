//
//  ContentView.swift
//  VisualEffectCard
//
//  Created by 曾品瑞 on 2024/3/12.
//

import SwiftUI

struct ContentView: View {
    @State private var indicator: Bool=true
    @State private var rotation: Bool=true
    @State private var scale: CGFloat=0.1
    
    @ViewBuilder
    private func CardView(_ card: Card) -> some View {
        RoundedRectangle(cornerRadius: 20).fill(card.color.gradient)
    }
    
    private func excessMin(_ proxy: GeometryProxy, offset: CGFloat=10) -> CGFloat {
        return self.progress(proxy)*offset
    }
    private func minX(_ proxy: GeometryProxy) -> CGFloat {
        let min: CGFloat=proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return min<0 ? 0:-min
    }
    private func progress(_ proxy: GeometryProxy, limit: CGFloat=2) -> CGFloat {
        let max: CGFloat=proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width: CGFloat=proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        return min((max/width)-1, limit)
    }
    private func rotation(_ proxy: GeometryProxy, rotation: CGFloat=5) -> Angle {
        return Angle(degrees: self.progress(proxy)*rotation)
    }
    private func scale(_ proxy: GeometryProxy, scale: CGFloat=0.1) -> CGFloat {
        return 1-(self.progress(proxy)*scale)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader {
                    let size: CGSize=$0.size
                    
                    ScrollView(.horizontal, showsIndicators: self.indicator) {
                        HStack(spacing: 0) {
                            ForEach(VisualEffectCard.card) {card in
                                self.CardView(card)
                                    .padding(.horizontal, 50)
                                    .frame(width: size.width)
                                    .visualEffect {(content, proxy) in
                                        content
                                            .scaleEffect(self.scale(proxy, scale: self.scale), anchor: .trailing)
                                            .rotationEffect(self.rotation(proxy, rotation: self.rotation ? 5:0))
                                            .offset(x: self.minX(proxy))
                                            .offset(x: self.excessMin(proxy, offset: self.rotation ? 8:10))
                                    }
                                    .zIndex(VisualEffectCard.card.zIndex(card))
                            }
                        }
                        .padding(.vertical)
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicatorsFlash(trigger: self.indicator)
                }
                .frame(height: 400)
                .animation(.snappy, value: self.rotation)
                .animation(.snappy, value: self.scale)
                
                VStack(spacing: 10) {
                    Toggle("Rotation", isOn: self.$rotation)
                    
                    Toggle("Indicator", isOn: self.$indicator)
                    
                    Stepper("Scale: \(self.scale, specifier: "%.1f")", value: self.$scale, in: 0...1, step: 0.1)
                        .animation(.snappy, value: self.scale)
                        .contentTransition(.numericText(value: self.scale))
                }
                .padding()
                .background(.bar, in: .rect(cornerRadius: 10))
                .padding()
            }
            .navigationTitle("Stacked Title")
        }
    }
}
