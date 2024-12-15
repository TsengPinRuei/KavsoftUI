//
//  ContentView.swift
//  ParallaxScrollView
//
//  Created by 曾品瑞 on 2023/11/30.
//

import SwiftUI

struct ContentView: View {
    @Namespace var namespace
    
    @State private var show: Bool=false
    @State private var select: UUID=UUID()
    @State private var index: Int=0
    @State private var drag: CGFloat=0
    @State private var width: CGFloat=350
    @State private var card: [Card]=ParallaxScrollView.card
    
    private var number: Int { return ParallaxScrollView.card.count }
    private let peek: CGFloat = 30
    private let threshold: CGFloat=100
    
    private func calculateOffset() -> CGFloat {
        return -CGFloat(self.index)*(self.width+self.peek)
    }
    private func calculateScale(at index: Int, in proxy: GeometryProxy) -> CGFloat {
        return 0.8+(0.2*(1-min(1, (abs(proxy.size.width/2-(CGFloat(self.index)*(self.width+self.peek)+(self.calculateOffset()+self.drag))-self.width/2))/(self.width+self.peek))))
    }
    private func finalPosition(value: DragGesture.Value) {
        if(value.predictedEndTranslation.width>self.threshold && self.index>0) {
            self.index-=1
        } else if(value.predictedEndTranslation.width < -self.threshold && self.index<self.number-1) {
            self.index+=1
        }
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                
                Text("Swipe Left or right").font(.title)
                
                Image(systemName: "arrow.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            .bold()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding([.top, .horizontal])
            .zIndex(1)
            
            if(!self.show) {
                GeometryReader {reader in
                    HStack(spacing: self.peek) {
                        ForEach(self.card.indices, id: \.self) {index in
                            ImageCard(card: self.card[index], namespace: self.namespace, show: self.$show, width: self.$width)
                                .frame(width: self.width)
                                .scaleEffect(self.calculateScale(at: index, in: reader))
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.smooth) {
                                        self.show.toggle()
                                        self.select=self.card[index].id
                                    }
                                }
                        }
                    }
                    .offset(x: self.calculateOffset()+self.drag)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged {value in
                                withAnimation(.bouncy) {
                                    self.drag=value.translation.width
                                }
                            }
                            .onEnded {value in
                                withAnimation(.bouncy) {
                                    self.finalPosition(value: value)
                                    self.drag=0
                                }
                            }
                    )
                }
                .padding(.leading)
                .offset(y: 150)
            }
            
            if(self.show) {
                ForEach(self.card) {card in
                    if(card.id==self.select) {
                        ImageDetail(namespace: self.namespace, card: card, show: self.$show)
                            .overlay(alignment: .topTrailing) {
                                Button {
                                    withAnimation(.smooth) {
                                        self.show=false
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.title3)
                                        .foregroundStyle(.black)
                                        .padding(10)
                                        .background(.ultraThinMaterial)
                                        .clipShape(.circle)
                                }
                                .padding(.trailing)
                            }
                    }
                }
            }
        }
        .background {
            Image(self.card[self.index].name)
                .resizable()
                .scaledToFill()
                .overlay(.ultraThinMaterial)
        }
    }
}
