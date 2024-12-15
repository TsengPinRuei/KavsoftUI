//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by 曾品瑞 on 2024/2/6.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ToDo.self)
    }
}
