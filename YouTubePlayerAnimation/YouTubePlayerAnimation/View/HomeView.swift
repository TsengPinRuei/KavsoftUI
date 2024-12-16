//
//  HomeView.swift
//  YouTubePlayerAnimation
//
//  Created by 曾品瑞 on 2024/3/11.
//

import SwiftUI

struct HomeView: View {
    @State private var close: Bool=false
    @State private var configuration: Configuration=Configuration()
    @State private var tab: Tab=Tab.home
    
    @ViewBuilder
    private func HomeTabView() -> some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(YouTubePlayerAnimation.player) {player in
                        self.PlayerView(player) {
                            self.configuration.select=player
                            withAnimation(.easeInOut(duration: 0.25)) {
                                self.configuration.show=true
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThickMaterial, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("YouTube")
                        .bold()
                        .font(.largeTitle)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Image(systemName: "tv.badge.wifi")
                            .resizable()
                            .scaledToFit()
                        
                        Image(systemName: "bell")
                            .resizable()
                            .scaledToFit()
                        
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                    }
                    .font(.body)
                }
            }
        }
    }
    @ViewBuilder
    private func PlayerView(_ player: Player, tap: @escaping () -> ()) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(player.image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(.rect)
                .contentShape(.rect)
                .onTapGesture(perform: tap)
            
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill").font(.title)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(player.title).font(.body)
                    
                    HStack(spacing: 5) {
                        Text(player.author)
                        
                        Text("• 9 Hours Ago")
                    }
                    .font(.callout)
                    .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
        }
    }
    @ViewBuilder
    private func TabBarView() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {tab in
                VStack(spacing: 5) {
                    Image(systemName: tab.symbol).font(.title3)
                    
                    Text(tab.rawValue).font(.caption)
                }
                .foregroundStyle(self.tab==tab ? Color.primary:.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.tab=tab
                    }
                }
            }
        }
        .frame(height: 50)
        .overlay(alignment: .top) {
            Divider()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(height: self.tabBarHeight)
        .background(.background)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: self.$tab) {
                self.HomeTabView().setUpTab(.home)
                
                Text(Tab.short.rawValue).setUpTab(.short)
                
                Text(Tab.subscription.rawValue).setUpTab(.subscription)
                
                Text(Tab.you.rawValue).setUpTab(.you)
            }
            .padding(.bottom, self.tabBarHeight)
            
            GeometryReader {
                let size: CGSize=$0.size
                
                if(self.configuration.show) {
                    MiniView(size: size, configuration: self.$configuration) {
                        self.close=true
                        withAnimation(.smooth(duration: 0.25), completionCriteria: .logicallyComplete) {
                            self.configuration.show=false
                        } completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                self.configuration.reset()
                                self.configuration.select=nil
                                self.close=false
                            }
                        }
                    }
                }
            }
            
            self.TabBarView().offset(y: self.configuration.show ? self.tabBarHeight-self.configuration.progress*self.tabBarHeight:0)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .disabled(self.close)
    }
}
