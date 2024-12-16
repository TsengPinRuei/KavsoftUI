//
//  Note.swift
//  NoteApp
//
//  Created by 曾品瑞 on 2024/10/10.
//

import SwiftUI
import SwiftData

@Model
class Note {
    var id: String=UUID().uuidString
    var date: Date=Date()
    var colorName: String
    var title: String
    var content: String
    var hit: Bool=false
    var color: Color {
        switch(self.colorName) {
        case "red": return .red
        case "orange": return .orange
        case "yellow": return .yellow
        case "green": return .green
        case "blue": return .blue
        case "purple": return .purple
        case "white": return .white
        default: return .gray
        }
    }
    
    init(colorName: String, title: String, content: String) {
        self.colorName=colorName
        self.title=title
        self.content=content
    }
}
