//
//  PlayerView.swift
//  YouTubeVideoPlayer
//
//  Created by 曾品瑞 on 2024/4/14.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> some AVPlayerViewController {
        let controller: AVPlayerViewController=AVPlayerViewController()
        controller.player=self.player
        controller.showsPlaybackControls=false
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
