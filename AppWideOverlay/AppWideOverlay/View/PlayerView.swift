//
//  PlayerView.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @Binding var show: Bool
    
    @State private var current: CGSize=CGSize.zero
    @State private var last: CGSize=CGSize.zero
    @State private var player: AVPlayer?
    
    var url: URL? {
        if let bundle=Bundle.main.path(forResource: "city", ofType: "mp4") { return URL(filePath: bundle) } else { return nil }
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            Group {
                if let _=self.url {
                    VideoPlayer(player: self.player)
                        .background(.black)
                        .clipShape(.rect(cornerRadius: 20))
                        .overlay(alignment: .topTrailing) {
                            Button {
                                withAnimation(.snappy) {
                                    self.show.toggle()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                    self.player=nil
                                }
                            } label: {
                                Circle()
                                    .fill(.black)
                                    .frame(width: 25, height: 25)
                                    .overlay(alignment: .top) {
                                        Text("x")
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                            .offset(y: 1)
                                    }
                            }
                            .padding([.top, .trailing])
                        }
                } else {
                    RoundedRectangle(cornerRadius: 20)
                }
            }
            .frame(height: 200)
            .offset(self.current)
            .gesture(
                DragGesture()
                    .onChanged {value in
                        let translation: CGSize=value.translation+self.last
                        self.current=translation
                    }
                    .onEnded {value in
                        withAnimation(.bouncy) {
                            self.current.width=0
                            if(self.current.height<0) {
                                self.current.height=0
                            }
                            if(self.current.height>size.height-200) {
                                self.current.height=size.height-200
                            }
                        }
                        
                        self.last=self.current
                    }
            )
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.horizontal)
        .transition(.blurReplace)
        .onAppear {
            if let url=self.url {
                self.player=AVPlayer(url: url)
                self.player?.play()
            }
        }
    }
}
