//
//  Item.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct Item: Identifiable {
    var id: UUID=UUID()
    var title: String
    var color: Color
    var symbol: String
}

var fullScreenCoverView: [Item]=[
    Item(title: "Book", color: .green, symbol: "book.fill"),
    Item(title: "Stack", color: .orange, symbol: "square.stack.3d.up"),
    Item(title: "Memo", color: .yellow, symbol: "square.and.pencil")
]
var sheetView: [Item]=[
    Item(title: "Book", color: .green, symbol: "book.fill"),
    Item(title: "Stack", color: .orange, symbol: "square.stack.3d.up"),
    Item(title: "Memo", color: .yellow, symbol: "square.and.pencil")
]
var navigationLinkView: [Item]=[
    Item(title: "Book", color: .green, symbol: "book.fill"),
    Item(title: "Stack", color: .orange, symbol: "square.stack.3d.up"),
    Item(title: "Memo", color: .yellow, symbol: "square.and.pencil")
]
