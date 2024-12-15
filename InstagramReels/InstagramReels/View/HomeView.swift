//
//  HomeView.swift
//  InstagramReels
//
//  Created by 曾品瑞 on 2023/11/14.
//

import SwiftUI

struct HomeView: View {
    @State private var count: [Like]=[]
    @State private var reel: [Reel]=InstagramReels.reel
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(self.$reel) {$reel in
                    ReelView(reel: $reel, count: self.$count, size: self.size, safeArea: self.safeArea)
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical)
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background(.black)
        .overlay(alignment: .topLeading) {
            ZStack {
                ForEach(self.count) {count in
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 75))
                        .foregroundStyle(.red.gradient)
                        .frame(width: 100, height: 100)
                        .animation(.smooth) {view in
                            view
                                .scaleEffect(count.animate ? 1:2)
                                .rotationEffect(Angle(degrees: count.animate ? 0:Double.random(in: -30...30)))
                        }
                        .offset(x: count.tap.x-50, y: count.tap.y-50)
                        .offset(y: count.animate ? -(count.tap.y+self.safeArea.top):0)
                }
            }
        }
        .overlay(alignment: .top) {
            Text("Reels")
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button("", systemImage: "camera") {
                        
                    }
                    .font(.title2)
                }
                .foregroundStyle(.white)
                .padding(.top, self.safeArea.top+15)
                .padding(.horizontal)
        }
        .environment(\.colorScheme, .dark)
    }
}
