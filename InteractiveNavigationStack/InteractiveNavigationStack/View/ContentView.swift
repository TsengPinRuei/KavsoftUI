//
//  ContentView.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var fullSwipe: Bool=true
    
    var body: some View {
        FullSwipeStack {
            List {
                Section("Sample Header") {
                    NavigationLink("Full Swipe View") {
                        List {
                            Toggle("Full Swipe Pop", isOn: self.$fullSwipe).fullSwipeDismiss(self.fullSwipe)
                        }
                        .navigationTitle("Full Swipe View")
                    }
                    
                    NavigationLink("Leading Swipe View") {
                        Text("")
                            .navigationTitle("Leading Swipe View")
                    }
                }
            }
            .navigationTitle("Full Swipe Pop")
        }
    }
}

#Preview {
    ContentView()
}
