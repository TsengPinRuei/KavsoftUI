//
//  HomeView.swift
//  MessengerGradientEffect
//
//  Created by 曾品瑞 on 2024/10/4.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader {proxy in
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(MessengerGradientEffect.message) {message in
                        MessageView(screen: proxy, message: message)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    HomeView()
}
