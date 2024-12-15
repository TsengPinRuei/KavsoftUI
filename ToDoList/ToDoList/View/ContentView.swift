//
//  ContentView.swift
//  ToDoList
//
//  Created by 曾品瑞 on 2024/2/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView().navigationTitle("To Do List")
        }
    }
}
