//
//  ContentView.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/12.
//

import SwiftUI

struct ContentView: View {
    @State private var slow: Bool=false
    
    var coordinator: UICoordinator=UICoordinator()
    
    var body: some View {
        NavigationStack {
            HomeView(slow: self.$slow)
                .environment(self.coordinator)
                .allowsTightening(self.coordinator.current==nil)
        }
        .overlay {
            Rectangle()
                .fill(.background)
                .ignoresSafeArea()
                .opacity(self.coordinator.animate ? 1:0)
        }
        .overlay {
            if(self.coordinator.current != nil) {
                DetailView(slow: self.$slow)
                    .environment(self.coordinator)
                    .allowsHitTesting(self.coordinator.show)
            }
        }
        .overlayPreferenceValue(HeroKey.self) {value in
            if let current=self.coordinator.current,
               let start=value[current.id+"START"],
               let end=value[current.id+"END"] {
                HeroView(nature: current, start: start, end: end).environment(self.coordinator)
            }
        }
    }
}
