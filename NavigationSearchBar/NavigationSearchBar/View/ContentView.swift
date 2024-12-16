//
//  ContentView.swift
//  NavigationSearchBar
//
//  Created by 曾品瑞 on 2024/4/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView().toolbar(.hidden, for: .navigationBar)
        }
    }
}
