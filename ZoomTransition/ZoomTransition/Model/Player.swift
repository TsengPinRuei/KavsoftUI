//
//  Player.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable {
    @Binding var player: AVPlayer?
    
    func makeUIViewController(context: Context) -> some AVPlayerViewController {
        let controller: AVPlayerViewController=AVPlayerViewController()
        controller.player=self.player
        controller.showsPlaybackControls=false
        controller.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.player=self.player
    }
}
