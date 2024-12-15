//
//  ReelView.swift
//  InstagramReels
//
//  Created by 曾品瑞 on 2023/11/14.
//

import SwiftUI
import AVKit

struct ReelView: View {
    @Binding var reel: Reel
    @Binding var count: [Like]
    
    @State private var player: AVPlayer?
    @State private var loop: AVPlayerLooper?
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    @ViewBuilder
    private func DetailView() -> some View {
        HStack(alignment: .bottom, spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: "person.circle.fill").font(.largeTitle)
                    
                    Text(self.reel.author)
                        .font(.callout)
                        .lineLimit(1)
                }
                .foregroundStyle(.white)
                
                Text("What a wonderful view here!  Let watch it together :)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .clipped()
            }
            
            Spacer(minLength: 0)
            
            VStack(spacing: 35) {
                Button("", systemImage: self.reel.like ? "suit.heart.fill":"suit.heart") {
                    self.reel.like.toggle()
                }
                .foregroundStyle(self.reel.like ? .red:.white)
                .symbolEffect(.bounce, value: self.reel.like)
                
                Button("", systemImage: "message") {}
                
                Button("", systemImage: "paperplane") {}
                
                Button("", systemImage: "ellipsis") {}
            }
            .font(.title2)
            .foregroundStyle(.white)
        }
        .padding(.leading)
        .padding(.trailing, 10)
        .padding(.bottom, self.safeArea.bottom+15)
    }
    
    private func playAndPause(_ value: CGRect) {
        if(-value.minY<value.height*0.5 && value.minY<value.height*0.5) {
            self.player?.play()
        } else {
            self.player?.pause()
        }
        
        if(value.minY>=self.size.height || -value.minY>=self.size.height) {
            self.player?.seek(to: .zero)
        }
    }
    
    var body: some View {
        GeometryReader {
            let frame: CGRect=$0.frame(in: .scrollView(axis: .vertical))
            
            VideoView(player: self.$player)
                .preference(key: OffsetKey.self, value: frame)
                .onPreferenceChange(OffsetKey.self) {value in
                    self.playAndPause(value)
                }
                .overlay(alignment: .bottom) {
                    self.DetailView()
                }
                .onTapGesture(count: 2) {position in
                    let id: UUID=UUID()
                    self.count.append(Like(id: id, tap: position, animate: false))
                    withAnimation(.snappy(duration: 1.2), completionCriteria: .logicallyComplete) {
                        if let index=self.count.firstIndex(where: { $0.id==id }) {
                            self.count[index].animate=true
                        }
                    } completion: {
                        self.count.removeAll(where: { $0.id==id })
                    }
                    
                    self.reel.like=true
                }
                .onAppear {
                    guard self.player==nil else { return }
                    guard let path: String=Bundle.main.path(forResource: self.reel.name, ofType: "mp4") else { return }
                    
                    let url: URL=URL(filePath: path)
                    let item: AVPlayerItem=AVPlayerItem(url: url)
                    let queue: AVQueuePlayer=AVQueuePlayer(playerItem: item)
                    self.loop=AVPlayerLooper(player: queue, templateItem: item)
                    self.player=queue
                }
                .onDisappear {
                    self.player=nil
                }
        }
    }
}
