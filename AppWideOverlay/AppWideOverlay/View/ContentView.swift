//
//  ContentView.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var player: Bool=false
    @State private var sheet: Bool=false
    
    var body: some View {
        NavigationStack {
            List {
                Button("Floating Player") {
                    self.player.toggle()
                }
                .universal(show: self.$player) {
                    PlayerView(show: self.$player)
                }
                
                NavigationLink("ProgressView", destination: ProgressView()).foregroundStyle(.blue)
                
                Button("Sheet") {
                    self.sheet.toggle()
                }
            }
        }
        .sheet(isPresented: self.$sheet) {
            SheetView(count: 0)
        }
    }
}

#Preview {
    RootView {
        ContentView()
    }
}
