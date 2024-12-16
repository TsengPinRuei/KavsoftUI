//
//  HomeView.swift
//  NavigationSearchBar
//
//  Created by 曾品瑞 on 2024/4/30.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var scheme
    
    @FocusState private var search: Bool
    
    @Namespace private var animation
    
    @State private var text: String=""
    @State private var active: Tab=Tab.all
    
    @ViewBuilder
    private func BarView(_ title: String) -> some View {
        GeometryReader {reader in
            let height: CGFloat=reader.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let minY: CGFloat=reader.frame(in: .scrollView(axis: .vertical)).minY
            let progress: CGFloat=self.search ? 1:max(min(-minY/50, 1), 0)
            let scale: CGFloat=minY>0 ? 1+max(min(minY/height, 1), 0):1
            
            VStack(spacing: 10) {
                Text(title)
                    .bold()
                    .font(.largeTitle)
                    .scaleEffect(scale, anchor: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass").font(.title3)
                    
                    TextField("Search", text: self.$text).focused(self.$search)
                    
                    if(self.search) {
                        Button {
                            self.search=false
                        } label: {
                            Image(systemName: "xmark").font(.title3)
                        }
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                    }
                }
                .foregroundStyle(Color.primary)
                .padding(.vertical, 10)
                .padding(.horizontal, 16-(progress*16))
                .frame(height: 50)
                .clipShape(.capsule)
                .background {
                    RoundedRectangle(cornerRadius: 20-progress*20)
                        .fill(.background)
                        .shadow(color: Color(.systemGray3), radius: 5, x: 0, y: 5)
                        .padding(.top, -progress*200)
                        .padding(.bottom, -progress*70)
                        .padding(.horizontal, -progress*16)
                }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(Tab.allCases, id: \.rawValue) {tab in
                            Button {
                                withAnimation(.snappy) {
                                    self.active=tab
                                }
                            } label: {
                                Text(tab.rawValue)
                                    .font(.callout)
                                    .foregroundStyle(self.active==tab ? (self.scheme == .dark ? .black:.white):Color.primary)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background {
                                        if(self.active==tab) {
                                            Capsule()
                                                .fill(Color.primary)
                                                .matchedGeometryEffect(id: "ACTIVETAB", in: self.animation)
                                        } else {
                                            Capsule().fill(.background)
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(height: 50)
            }
            .padding(.top, 20)
            .safeAreaPadding(.horizontal)
            .offset(y: (minY<0 || self.search) ? -minY:0)
            .offset(y: -progress*70)
        }
        .frame(height: 200)
        .padding(.bottom, 10)
        .padding(.bottom, self.search ? -70:0)
    }
    @ViewBuilder
    private func BodyView() -> some View {
        ForEach(0..<50, id: \.self) {_ in
            HStack(spacing: 10) {
                Circle().frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    Rectangle().frame(width: 150, height: 10)
                    
                    Rectangle().frame(height: 10)
                    
                    Rectangle().frame(width: 80, height: 10)
                }
            }
            .foregroundStyle(.gray)
            .padding(.horizontal)
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                self.BodyView()
            }
            .safeAreaPadding()
            .safeAreaInset(edge: .top, spacing: 0) {
                self.BarView("Message")
            }
            .animation(.smooth(duration: 0.25), value: self.search)
        }
        .scrollTargetBehavior(SearchTarget())
        .background(Color(.systemGray5))
        .contentMargins(.top, 200, for: .scrollIndicators)
    }
}

#Preview {
    ContentView()
}
