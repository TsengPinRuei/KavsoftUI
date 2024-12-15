//
//  HomeView.swift
//  AnimatedStickyHeader
//
//  Created by 曾品瑞 on 2023/12/10.
//

import SwiftUI

struct HomeView: View {
    @State private var album: [Album]=AnimatedStickyHeader.album
    
    var safeArea: EdgeInsets
    var size: CGSize
    
    @ViewBuilder
    private func ArtView() -> some View {
        let height: CGFloat=self.size.height*0.5
        
        GeometryReader {reader in
            let minY: CGFloat=reader.frame(in: .named("SCROLL")).minY
            let size: CGSize=reader.size
            let progress: CGFloat=minY/(height*(minY>0 ? 0.5:0.8))
            
            Image(.patrick)
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height+(minY>0 ? minY:0))
                .clipped()
                .overlay {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                .linearGradient(
                                    colors: [
                                        .black.opacity(0-progress),
                                        .black.opacity(0.2-progress),
                                        .black.opacity(0.4-progress),
                                        .black.opacity(0.6-progress),
                                        .black.opacity(0.8-progress),
                                        .black
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        VStack(spacing: 0) {
                            Text("Patrick\nMusic")
                                .bold()
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                            
                            Text("900,927 MONTHLY LISTENERS")
                                .bold()
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.top)
                        }
                        .opacity(1+(progress>0 ? -progress:progress))
                        .padding(.bottom, 50)
                        .offset(y: minY<0 ? minY:0)
                    }
                }
                .offset(y: -minY)
        }
        .frame(height: height+self.safeArea.top)
    }
    @ViewBuilder
    private func HeaderView() -> some View {
        GeometryReader {reader in
            let minY: CGFloat=reader.frame(in: .named("SCROLL")).minY
            let height: CGFloat=self.size.height*0.5
            let progress: CGFloat=minY/(height*(minY>0 ? 0.5:0.8))
            let title: CGFloat=minY/height
            
            HStack(spacing: 20) {
                Button("", systemImage: "chevron.left") {}
                    .font(.title3)
                    .foregroundStyle(.white)
                
                if(progress>10) {
                    Spacer(minLength: 0)
                    
                    Button { } label: {
                        Text("FOLLOWING")
                            .bold()
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .border(.white, width: 1)
                    }
                    .opacity(progress-10)
                } else {
                    Spacer(minLength: 0)
                    
                    Text("Patrick Music")
                        .bold()
                        .font(.title3)
                        .foregroundStyle(.white)
                        .transition(.opacity.animation(.smooth))
                    
                    Spacer(minLength: 0)
                }
                
                Button("", systemImage: progress>10 ? "ellipsis":"arrow.clockwise") {
                    if(progress<=10) {
                        withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                            self.album=[]
                        } completion: {
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                withAnimation(.smooth) {
                                    self.album=AnimatedStickyHeader.album.shuffled()
                                }
                            }
                        }
                    }
                }
                .font(.title3)
                .foregroundStyle(.white)
            }
            .overlay {
                Text("White Sounds")
                    .bold()
                    .offset(y: -title>0.7 ? 0:40)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -title>0.7)
            }
            .padding(.top, self.safeArea.top+10)
            .padding([.horizontal, .bottom])
            .background(.black.opacity((progress>10 || self.album.isEmpty) ? 0:1))
            .offset(y: -minY)
        }
        .frame(height: 30)
    }
    @ViewBuilder
    private func SoundView() -> some View {
        if(self.album.isEmpty) {
            ProgressView()
                .tint(.white)
                .padding()
                .transition(.opacity)
        } else {
            VStack(spacing: 20) {
                ForEach(self.album.indices, id: \.self) {index in
                    HStack(spacing: 30) {
                        Text("\(index+1)")
                            .bold()
                            .font(.callout)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(self.album[index].name).bold()
                            
                            Text("20,010,927").font(.caption)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .foregroundStyle(.gray)
            .padding()
            .transition(.opacity)
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                self.ArtView()
                
                Text("Popular")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.top, -30)
                
                self.SoundView().padding(.top)
                
                self.HeaderView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
}
