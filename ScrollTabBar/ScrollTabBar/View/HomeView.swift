//
//  HomeView.swift
//  ScrollTabBar
//
//  Created by 曾品瑞 on 2024/4/24.
//

import SwiftUI

struct HomeView: View {
    @State private var progress: CGFloat=CGFloat.zero
    @State private var active: TabBar.Tab=TabBar.Tab.you
    @State private var barState: TabBar.Tab?
    @State private var mainState: TabBar.Tab?
    @State private var tab: [TabBar]=[
        TabBar(id: TabBar.Tab.you),
        TabBar(id: TabBar.Tab.all),
        TabBar(id: TabBar.Tab.follow),
        TabBar(id: TabBar.Tab.topic),
        TabBar(id: TabBar.Tab.ccu)
    ]
    
    @ViewBuilder
    private func HeaderView() -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color(.systemGray5))
            .frame(height: 30)
            .overlay(alignment: .leading) {
                HStack(spacing: 5) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 6)
                        .padding(.leading, 10)
                    
                    Text("Search").font(.headline)
                }
                .foregroundStyle(.gray)
            }
            .padding(10)
    }
    @ViewBuilder
    private func TabBarView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(self.$tab) {$tab in
                    Button {
                        withAnimation(.snappy) {
                            self.active=tab.id
                            self.barState=tab.id
                            self.mainState=tab.id
                        }
                    } label: {
                        Text(tab.id.rawValue)
                            .bold()
                            .font(.title3)
                            .foregroundStyle(self.active==tab.id ? Color.primary:.gray)
                            .padding(.vertical, 10)
                            .contentShape(.rect)
                            .safeAreaPadding(.horizontal)
                    }
                    .buttonStyle(.plain)
                    .rect {rect in
                        tab.size=rect.size
                        tab.min=rect.minX
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: Binding(get: { return self.barState }, set: {_ in }), anchor: .center)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.primary)
                    .frame(height: 0.5)
                
                let input=self.tab.indices.compactMap { return CGFloat($0) }
                let output=self.tab.compactMap { return $0.size.width }
                let range=self.tab.compactMap { return $0.min }
                let position: CGFloat=self.progress.interpolate(input: input, output: range)
                let width: CGFloat=self.progress.interpolate(input: input, output: output)
                
                Rectangle()
                    .fill(.blue)
                    .frame(width: width, height: 3)
                    .offset(x: position)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            self.HeaderView()
            self.TabBarView()
            
            GeometryReader {
                let size: CGSize=$0.size
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(self.tab) {tab in
                            Text(tab.id.rawValue)
                                .bold()
                                .font(.largeTitle)
                                .frame(width: size.width, height: size.height)
                                .contentShape(.rect)
                        }
                    }
                    .scrollTargetLayout()
                    .rect {rect in
                        self.progress = -rect.minX/size.width
                    }
                }
                .scrollPosition(id: self.$mainState)
                .scrollTargetBehavior(.paging)
                .onChange(of: self.mainState) {(_, new) in
                    if let new {
                        withAnimation(.snappy) {
                            self.barState=new
                            self.active=new
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
