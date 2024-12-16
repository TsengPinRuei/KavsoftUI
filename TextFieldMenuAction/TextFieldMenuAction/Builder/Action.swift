//
//  Action.swift
//  TextFieldMenuAction
//
//  Created by 曾品瑞 on 2024/11/14.
//

import Foundation

@resultBuilder
struct TextActionBuilder {
    static func buildBlock(_ components: TextAction...) -> [TextAction] {
        components.compactMap({ $0 })
    }
}
