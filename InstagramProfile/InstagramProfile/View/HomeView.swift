//
//  HomeView.swift
//  InstagramProfile
//
//  Created by 曾品瑞 on 2023/12/12.
//

import SwiftUI

struct HomeView: View {
    @Namespace private var animation
    
    @State private var offset: CGFloat=0
    @State private var tab: String="squareshape.split.3x3"
    
    @ViewBuilder
    private func ImageView(index: Int, width: CGFloat) -> some View {
        Image("landscape\(index%10+1)")
            .resizable()
            .scaledToFill()
            .frame(width: width, height: 150)
            .clipShape(.rect)
    }
    @ViewBuilder
    private func InformationView(number: String, text: String) -> some View {
        VStack {
            Text(number)
                .bold()
                .font(.title2)
                .foregroundStyle(.primary)
            
            Text(text).foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button {} label: {
                    HStack(spacing: 5) {
                        Image(systemName: "lock")
                        
                        Text("7u5T1n_T53n6")
                            .bold()
                            .font(.title2)
                        
                        Image(systemName: "chevron.down")
                    }
                }
                
                Spacer(minLength: 0)
                
                Button("", systemImage: "plus.app") {}.font(.title)
                
                Button {} label: {
                    VStack(spacing: 5) {
                        ForEach(0..<3, id: \.self) {_ in
                            Capsule().frame(width: 20, height: 3)
                        }
                    }
                }
            }
            .foregroundStyle(.primary)
            .padding([.horizontal, .top])
            .overlay(alignment: .bottom) {
                GeometryReader {reader -> Color in
                    let minY: CGFloat=reader.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        if(self.offset==0) {
                            self.offset=minY
                        }
                    }
                    
                    return Color.clear
                }
                .frame(width: 0, height: 0)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Divider()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(.patrick)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(.circle)
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "plus")
                                        .foregroundStyle(.white)
                                        .padding(5)
                                        .background(.blue)
                                        .clipShape(.circle)
                                        .padding(2)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .offset(x: 5, y: 5)
                                        .padding([.trailing, .bottom], 5)
                                }
                        }
                        
                        self.InformationView(number: "27", text: "Posts")
                        
                        self.InformationView(number: "90", text: "Followers")
                        
                        self.InformationView(number: "9", text: "Following")
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Justin Tseng").bold()
                        
                        Text("Just For Fun")
                            .bold()
                            .foregroundStyle(.gray)
                        
                        Text("CCU\n-\nI know everything happens for a reason, by WHAT THE FUCK?").padding(.vertical, 10)
                        
                        Button {} label: {
                            HStack {
                                Image(systemName: "link")
                                
                                Text("Levent Geiger - Deserve It")
                            }
                            .bold()
                        }
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                    
                    HStack(spacing: 10) {
                        Button {} label: {
                            Text("Edit Profile")
                                .bold()
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThickMaterial)
                                .clipShape(.rect(cornerRadius: 5))
                        }
                        
                        Button {} label: {
                            Text("Share Profile")
                                .bold()
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThickMaterial)
                                .clipShape(.rect(cornerRadius: 5))
                        }
                        
                        Button {} label: {
                            HStack(spacing: 0) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10)
                                
                                Image(systemName: "person")
                            }
                            .padding(6)
                            .frame(width: 40)
                            .background(.ultraThickMaterial)
                            .clipShape(.rect(cornerRadius: 5))
                        }
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                    .padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Button {} label: {
                                VStack {
                                    Image(.landscape1)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(.circle)
                                        .padding(3)
                                        .background(Circle().stroke(.gray, lineWidth: 2))
                                    
                                    Text("Landscape")
                                }
                            }
                            
                            Button {} label: {
                                VStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                        .frame(width: 60, height: 60)
                                        .background(Circle().stroke(.gray, lineWidth: 2))
                                    
                                    Text("New")
                                }
                            }
                        }
                        .foregroundStyle(Color.primary)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    
                    GeometryReader {reader -> AnyView in
                        let minY: CGFloat=reader.frame(in: .global).minY
                        let offset: CGFloat=minY-self.offset
                        
                        return AnyView(
                            HStack(spacing: 0) {
                                TabBarButton(isSystem: true, image: "squareshape.split.3x3", animation: self.animation, tab: self.$tab)
                                
                                TabBarButton(isSystem: true, image: "play.rectangle", animation: self.animation, tab: self.$tab)
                                
                                TabBarButton(isSystem: true, image: "person.crop.square", animation: self.animation, tab: self.$tab)
                            }
                                .frame(height: 60, alignment: .bottom)
                                .background(Color.primary.colorInvert())
                                .offset(y: offset<0 ? -offset:0)
                        )
                    }
                    .frame(height: 60)
                    .zIndex(1)
                    
                    ZStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 3), spacing: 1) {
                            ForEach(1...27, id: \.self) {index in
                                GeometryReader {reader in
                                    let width: CGFloat=reader.frame(in: .global).width
                                    
                                    self.ImageView(index: index, width: width)
                                }
                                .frame(height: 150)
                            }
                        }
                    }
                }
            }
        }
    }
}
