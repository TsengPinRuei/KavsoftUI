//
//  ContentView.swift
//  AnimatedStickyHeader
//
//  Created by 曾品瑞 on 2023/12/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let safeArea: EdgeInsets=$0.safeAreaInsets
            let size: CGSize=$0.size
            
            HomeView(safeArea: safeArea, size: size).ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}
