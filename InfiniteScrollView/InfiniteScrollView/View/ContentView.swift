//
//  ContentView.swift
//  InfiniteScrollView
//
//  Created by 曾品瑞 on 2023/11/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView().navigationTitle("Looping ScrollView")
        }
    }
}
