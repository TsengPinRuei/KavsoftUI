//
//  HomeView.swift
//  ComplexScrollAnimation
//
//  Created by 曾品瑞 on 2023/11/6.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var scheme
    
    @State private var currentCard: UUID?
    @State private var item: [Item]=[]
    
    @ViewBuilder
    private func CardView(_ card: Card) -> some View {
        GeometryReader {
            let frame: CGRect=$0.frame(in: .scrollView(axis: .vertical))
            let minY: CGFloat=frame.minY
            let top: CGFloat=76
            let offset: CGFloat=min(minY-top, 0)
            let progress: CGFloat=max(min(-offset/top, 1), 0)
            let scale: CGFloat=1+progress
            
            ZStack {
                Rectangle()
                    .fill(card.bgColor)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(card.bgColor)
                            .overlay {
                                Circle().fill(.white.opacity(0.3))
                            }
                            .scaleEffect(2, anchor: .topLeading)
                            .offset(x: -50, y: -40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .scaleEffect(scale, anchor: .bottom)
                
                VStack(alignment: .leading, spacing: 5) {
                    Spacer(minLength: 0)
                    
                    Text("Current Card").font(.callout)
                    
                    Text(card.title)
                        .bold()
                        .font(.title)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .offset(y: progress * -25)
            }
            .offset(y: -offset)
            .offset(y: progress * -top)
        }
        .padding(.horizontal)
    }
    @ViewBuilder
    private func ItemView(_ item: Item) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.product)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text(item.type)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer(minLength: 0)
            
            Text(item.amount).bold()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    private func backgroundLimitOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY=proxy.frame(in: .scrollView).minY
        return minY<100 ? -minY+100:0
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Hello, Justin")
                        .bold()
                        .font(.largeTitle)
                        .frame(height: 45)
                        .padding(.horizontal)
                    
                    GeometryReader {
                        let frame: CGRect=$0.frame(in: .scrollView)
                        let minY: CGFloat=frame.minY.rounded()
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(ComplexScrollAnimation.card) {card in
                                    ZStack {
                                        if(minY==76) {
                                            self.CardView(card)
                                        } else {
                                            if(self.currentCard==card.id) {
                                                self.CardView(card)
                                            } else {
                                                Rectangle().fill(.clear)
                                            }
                                        }
                                    }
                                    .containerRelativeFrame(.horizontal)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollPosition(id: self.$currentCard)
                        .scrollTargetBehavior(.paging)
                        .scrollClipDisabled()
                        .scrollIndicators(.hidden)
                        .scrollDisabled(minY != 76)
                    }
                    .frame(height: 125)
                }
                
                LazyVStack(spacing: 15) {
                    Menu {
                        
                    } label: {
                        HStack(spacing: 5) {
                            Text("Filter By")
                            
                            Image(systemName: "chevron.down")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    ForEach(self.item) {item in
                        self.ItemView(item)
                    }
                }
                .padding(15)
                .mask {
                    Rectangle()
                        .visualEffect {(content, proxy) in
                            content.offset(y: self.backgroundLimitOffset(proxy))
                        }
                }
                .background {
                    GeometryReader {
                        let frame: CGRect=$0.frame(in: .scrollView)
                        let minY: CGFloat=min(frame.minY-125, 0)
                        let progress: CGFloat=max(min(-minY/25, 1), 0)
                        
                        RoundedRectangle(cornerRadius: 30*progress, style: .continuous)
                            .fill(self.scheme == .dark ? .black:.white)
                            .visualEffect {(content, proxy) in
                                content.offset(y: self.backgroundLimitOffset(proxy))
                            }
                    }
                }
            }
            .padding(.vertical)
        }
        .scrollTargetBehavior(CustomScrollBehavior())
        .scrollIndicators(.hidden)
        .onAppear {
            if(self.currentCard == nil) {
                self.currentCard=ComplexScrollAnimation.card.first?.id
            }
        }
        .onChange(of: self.currentCard) {(_, _) in
            withAnimation(.snappy) {
                self.item=ComplexScrollAnimation.item.shuffled()
            }
        }
    }
}
