//
//  HomeView.swift
//  ScrollToHideHeader
//
//  Created by 曾品瑞 on 2024/9/23.
//

import SwiftUI

struct HomeView: View {
    @State private var isScroll: Bool=false
    @State private var endOffset: CGFloat=0
    @State private var headerOffset: CGFloat=0
    @State private var scrollOffset: CGFloat=0
    
    @ViewBuilder
    private func CardView() -> some View {
        VStack(alignment: .leading) {
            Rectangle().frame(height: 200)
            
            HStack(alignment: .top, spacing: 20) {
                Circle().frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    RoundedRectangle(cornerRadius: 3).frame(height: 20)
                    
                    RoundedRectangle(cornerRadius: 3).frame(height: 20)
                    
                    RoundedRectangle(cornerRadius: 3).frame(width: 120, height: 20)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .padding(.bottom)
        }
        .foregroundStyle(.tertiary)
    }
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Image(.youTube)
                .resizable()
                .scaledToFit()
                .frame(height: 25)
            
            Spacer(minLength: 0)
            
            Button("", systemImage: "tv.badge.wifi") { }
            
            Button("", systemImage: "bell") { }
            
            Button("", systemImage: "magnifyingglass") { }
        }
        .font(.title2)
        .foregroundStyle(Color.primary)
        .padding()
    }
    
    var body: some View {
        GeometryReader {
            let safeArea: EdgeInsets=$0.safeAreaInsets
            let height: CGFloat=60+safeArea.top
            
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(1...20, id: \.self) {_ in
                        self.CardView()
                    }
                }
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                self.HeaderView()
                    .padding(.bottom, 10)
                    .frame(height: height, alignment: .bottom)
                    .background(.background)
                    .offset(y: -self.headerOffset)
            }
            .onScrollGeometryChange(for: CGFloat.self) {proxy in
                let maxHeight: CGFloat=proxy.contentSize.height-proxy.containerSize.height
                return max(min(proxy.contentOffset.y+height, maxHeight), 0)
            } action: {(old, new) in
                let isScroll: Bool=old<new
                
                self.headerOffset=min(max(new-self.endOffset, 0), height)
                self.isScroll=isScroll
                self.scrollOffset=new
            }
            .onScrollPhaseChange {(_, new) in
                if(!new.isScrolling && (self.headerOffset != 0 || self.headerOffset != height)) {
                    withAnimation(.smooth(duration: 0.2, extraBounce: 0)) {
                        if(self.headerOffset>height*0.5 && self.scrollOffset>height) {
                            self.headerOffset=height
                        } else {
                            self.headerOffset=0
                        }
                    }
                }
            }
            .onChange(of: self.isScroll) {
                self.endOffset=self.scrollOffset-self.headerOffset
            }
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
