//
//  Tab.swift
//  NavigationToRoot
//
//  Created by 曾品瑞 on 2024/2/27.
//

import Foundation

enum Tab: String {
    case home="Home"
    case setting="Setting"
    
    var symbol: String {
        switch(self) {
        case .home: return "house"
        case .setting: return "gearshape"
        }
    }
}
