//
//  MiniView.swift
//  YouTubePlayerAnimation
//
//  Created by 曾品瑞 on 2024/3/11.
//

import SwiftUI

struct MiniView: View {
    var size: CGSize
    
    @Binding var configuration: Configuration
    
    var close: () -> ()
    
    @State private var pause: Bool=true
    
    private let maxHeight: CGFloat=200
    private let minHeight: CGFloat=50
    
    @ViewBuilder
    private func ExpandContentView(_ player: Player) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(player.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(player.description).font(.callout)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.top, 10)
    }
    @ViewBuilder
    private func MiniContentView() -> some View {
        HStack(spacing: 0) {
            if let player=self.configuration.select {
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(player.title)
                            .font(.callout)
                            .textScale(.secondary)
                            .lineLimit(1)
                        
                        Text(player.author)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxHeight: .infinity)
                    .frame(maxHeight: 50)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            self.pause.toggle()
                        }
                    } label: {
                        Image(systemName: self.pause ? "pause.fill":"play.fill")
                            .frame(width: 35, height: 35)
                            .contentTransition(.symbolEffect(.replace))
                            .contentShape(.rect)
                    }
                    
                    Button(action: self.close) {
                        Image(systemName: "xmark")
                            .frame(width: 35, height: 35)
                            .contentShape(.rect)
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func VideoView() -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            Rectangle().fill(.black)
            
            if let player=self.configuration.select {
                Image(player.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: size.height)
            }
        }
    }
    
    private func generateProgress() {
        let progress: CGFloat=max(min(self.configuration.current/(self.size.height-self.minHeight), 1), .zero)
        self.configuration.progress=progress
    }
    
    var body: some View {
        let progress: CGFloat=self.configuration.progress>0.5 ? (self.configuration.progress-0.5)/0.5:0
        
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                GeometryReader {
                    let size: CGSize=$0.size
                    let height: CGFloat=size.height
                    let width: CGFloat=size.width-120
                    
                    self.VideoView().frame(width: 120+(width-width*progress), height: height)
                }
                .zIndex(1)
                
                self.MiniContentView()
                    .foregroundStyle(Color.primary)
                    .opacity(progress)
                    .padding(.leading, 100)
                    .padding(.leading)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            .frame(minHeight: self.minHeight, maxHeight: self.maxHeight)
            .zIndex(1)
            
            ScrollView(.vertical) {
                if let player=self.configuration.select {
                    self.ExpandContentView(player)
                }
            }
            .opacity(1.0-self.configuration.progress*1.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.background)
        .clipped()
        .contentShape(.rect)
        .offset(y: self.configuration.progress * -self.tabBarHeight)
        .frame(height: self.size.height-self.configuration.current, alignment: .top)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .gesture(
            DragGesture()
                .onChanged {value in
                    let start: CGFloat=value.startLocation.y
                    guard (start<self.maxHeight || start>self.size.height-(self.tabBarHeight+self.minHeight)) else { return }
                    
                    let height: CGFloat=self.configuration.end+value.translation.height
                    self.configuration.current=min(height, (self.size.height-self.minHeight))
                    self.generateProgress()
                }
                .onEnded {value in
                    let start: CGFloat=value.startLocation.y
                    guard (start<self.maxHeight || start>self.size.height-(self.tabBarHeight+self.minHeight)) else { return }
                    
                    let velocity: CGFloat=value.velocity.height*5
                    withAnimation(.smooth(duration: 0.25)) {
                        if(self.configuration.current+velocity>self.size.height*0.5) {
                            self.configuration.current=self.size.height-self.minHeight
                            self.configuration.end=self.configuration.current
                            self.configuration.progress=1
                        } else {
                            self.configuration.reset()
                        }
                    }
                }
                .simultaneously(with: TapGesture().onEnded {_ in
                    withAnimation(.smooth(duration: 0.25)) {
                        self.configuration.reset()
                    }
                })
        )
        .transition(.offset(y: self.configuration.progress==1 ? self.tabBarHeight:self.size.height))
        .onChange(of: self.configuration.select, initial: false) {
            withAnimation(.smooth(duration: 0.25)) {
                self.configuration.reset()
            }
        }
    }
}
