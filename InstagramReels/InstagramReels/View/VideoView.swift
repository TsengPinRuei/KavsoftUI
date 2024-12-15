//
//  VideoView.swift
//  InstagramReels
//
//  Created by 曾品瑞 on 2023/11/14.
//

import SwiftUI
import AVKit

struct VideoView: UIViewControllerRepresentable {
    @Binding var player: AVPlayer?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller: AVPlayerViewController=AVPlayerViewController()
        controller.player=self.player
        controller.videoGravity = .resizeAspectFill
        controller.showsPlaybackControls=false
        return controller
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player=self.player
    }
}
