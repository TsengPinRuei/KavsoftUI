//
//  ContentView.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//

import SwiftUI

struct ContentView: View {
    @State private var snap: Bool=false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.CCU)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .disintegration(delete: self.snap) {
                        //after removing the picture
                    }
                    .padding()
            }
            .navigationTitle("Disintegration Effect")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("REMOVE") {
                        self.snap=true
                    }
                    .bold()
                    .font(.largeTitle)
                    .tint(.primary)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
