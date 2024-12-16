//
//  Universal.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

@Observable
class Universal {
    struct Overlay: Identifiable {
        var id: String=UUID().uuidString
        var view: AnyView
    }
    
    var window: UIWindow?
    var view: [Overlay]=[]
}
