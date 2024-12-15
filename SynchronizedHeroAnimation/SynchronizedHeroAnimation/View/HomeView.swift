//
//  HomeView.swift
//  SynchronizedHeroAnimation
//
//  Created by 曾品瑞 on 2023/12/7.
//

import SwiftUI

struct HomeView: View {
    @State private var detailAnimation: Bool=false
    @State private var showDetail: Bool=false
    @State private var currentID: UUID?
    @State private var currentPost: Post?
    @State private var post: [Post]=SynchronizedHeroAnimation.post
    
    @ViewBuilder
    private func SocialButton(_ icon: String, tap: @escaping () -> ()) -> some View {
        Button("", systemImage: icon, action: tap)
            .font(.title3)
            .foregroundStyle(.primary)
    }
    @ViewBuilder
    private func LandscapeView(_ post: Post) -> some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.teal)
                    .frame(width: 30, height: 30)
                    .background(.background)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(post.name)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    
                    Text(post.content)
                }
                
                Spacer(minLength: 0)
                
                Button("", systemImage: "ellipsis") {
                    
                }
                .foregroundStyle(.primary)
                .offset(y: -10)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                GeometryReader {
                    let size=$0.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(post.landscape) {landscape in
                                LazyHStack {
                                    Image(landscape.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: size.width)
                                        .clipShape(.rect(cornerRadius: 10))
                                }
                                .frame(maxWidth: size.width)
                                .frame(height: size.height)
                                .anchorPreference(key: OffsetKey.self, value: .bounds) {anchor in
                                    return [landscape.id.uuidString:anchor]
                                }
                                .onTapGesture {
                                    self.currentID=landscape.id
                                    self.currentPost=post
                                    self.showDetail=true
                                }
                                .contentShape(.rect)
                                .opacity(self.currentID==landscape.id ? 0:1)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: .init(get: {
                        return post.scrollPostiion
                    }, set: {_ in
                    }))
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled()
                }
                .frame(height: 200)
                
                HStack(spacing: 10) {
                    self.SocialButton("suit.heart") {
                    }
                    
                    self.SocialButton("message") {
                    }
                    
                    self.SocialButton("arrow.2.squarepath") {
                    }
                    
                    self.SocialButton("paperplane") {
                    }
                }
            }
            .safeAreaPadding(.leading, 40)
            
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .background(.background )
                    .frame(width: 30, height: 30)
                
                Button("9 replies") {
                    
                }
                
                Button("27 Likes") {
                    
                }
                
                Spacer()
            }
            .foregroundStyle(.secondary)
            .textScale(.secondary)
        }
        .background(alignment: .leading) {
            Rectangle()
                .fill(.secondary)
                .frame(width: 1)
                .padding(.bottom, 30)
                .offset(x: 15, y: 10)
        }
    }
    
    private func currentImage() -> Landscape? {
        if let image=self.currentPost?.landscape.first(where: { $0.id==self.currentID }) {
            return image
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    ForEach(self.post) {post in
                        self.LandscapeView(post)
                    }
                }
                .safeAreaPadding(15)
            }
            .navigationTitle("Synchronized Hero")
        }
        .overlay {
            if let post=self.currentPost, self.showDetail {
                DetailView(show: self.$showDetail, animation: self.$detailAnimation, id: self.$currentID, post: post) {id in
                    if let index=self.post.firstIndex(where: { $0.id==post.id }) {
                        self.post[index].scrollPostiion=id
                    }
                }
                .transition(.offset(y: 5))
            }
        }
        .overlayPreferenceValue(OffsetKey.self) {value in
            GeometryReader {reader in
                if let id=self.currentID,
                   let source=value[id.uuidString],
                   let destination=value["DESTINATION\(id.uuidString)"],
                   let image=self.currentImage(),
                   self.showDetail {
                    let start=reader[source]
                    let end=reader[destination]
                    
                    Image(image.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: self.detailAnimation ? end.width:start.width, height: self.detailAnimation ? end.height:start.height)
                        .clipShape(.rect(cornerRadius: self.detailAnimation ? 0:10))
                        .offset(x: self.detailAnimation ? end.minX:start.minX, y: self.detailAnimation ? end.minY:start.minY)
                        .allowsHitTesting(false)
                }
            }
        }
    }
}
