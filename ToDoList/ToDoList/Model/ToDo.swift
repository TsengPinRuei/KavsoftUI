//
//  ToDo.swift
//  ToDoList
//
//  Created by 曾品瑞 on 2024/2/6.
//

import SwiftUI
import SwiftData

@Model
class ToDo {
    private(set) var taskID: String=UUID().uuidString
    var task: String
    var complete: Bool=false
    var priority: Priority=Priority.normal
    var update: Date=Date.now
    
    init(task: String, priority: Priority) {
        self.task=task
        self.priority=priority
    }
}

enum Priority: String, CaseIterable, Codable {
    case normal="Normal"
    case medium="Medium"
    case high="High"
    
    var color: Color {
        switch self {
        case .normal:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .red
        }
    }
}
