//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by 曾品瑞 on 2024/10/10.
//

import SwiftUI

@main
struct NoteAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for: Note.self)
        }
    }
}
