//
//  Tab.swift
//  ScrollableTabView
//
//  Created by 曾品瑞 on 2023/11/9.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case call="Call"
    case chat="Chat"
    case setting="Setting"
    
    var image: String {
        switch(self) {
        case .call:
            return "phone"
        case .chat:
            return "bubble.left.and.bubble.right"
        case .setting:
            return "gearshape"
        }
    }
}
