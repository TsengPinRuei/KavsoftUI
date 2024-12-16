//
//  AudioPlayerApp.swift
//  AudioPlayer
//
//  Created by 曾品瑞 on 2024/5/21.
//

import SwiftUI

@main
struct AudioPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(show: .constant(true), animation: Namespace().wrappedValue)
        }
    }
}
