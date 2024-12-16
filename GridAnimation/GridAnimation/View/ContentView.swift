//
//  ContentView.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView().toolbar(.hidden, for: .navigationBar)
        }
    }
}
