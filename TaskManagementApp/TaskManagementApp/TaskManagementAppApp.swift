//
//  TaskManagementAppApp.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/11.
//

import SwiftUI

@main
struct TaskManagementAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .modelContainer(for: Tasks.self)
        }
    }
}
