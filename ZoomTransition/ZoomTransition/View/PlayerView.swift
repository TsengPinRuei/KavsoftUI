//
//  PlayerView.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    @State private var player: AVPlayer?
    
    var nature: Nature
    
    var body: some View {
        Player(player: self.$player)
            .onAppear {
                guard self.player==nil else { return }
                self.player=AVPlayer(url: self.nature.url)
            }
            .onScrollVisibilityChange {visible in
                if(visible) {
                    self.player?.play()
                } else {
                    self.player?.pause()
                }
            }
            .onGeometryChange(for: Bool.self) {proxy in
                let minY: CGFloat=proxy.frame(in: .scrollView(axis: .vertical)).minY
                let height: CGFloat=proxy.size.height*0.9
                return -minY>height || minY>height
            } action: {value in
                if(value) {
                    self.player?.seek(to: .zero)
                }
            }
    }
}
