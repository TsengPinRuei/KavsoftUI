//
//  ContentView.swift
//  YouTubeVideoPlayer
//
//  Created by 曾品瑞 on 2024/4/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            let safeArea: EdgeInsets=$0.safeAreaInsets
            
            HomeView(size: size, safeArea: safeArea).ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}
