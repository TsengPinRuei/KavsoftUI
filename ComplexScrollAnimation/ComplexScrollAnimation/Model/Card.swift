//
//  Card.swift
//  ComplexScrollAnimation
//
//  Created by 曾品瑞 on 2023/11/6.
//

import SwiftUI

struct Card: Identifiable {
    var id: UUID=UUID()
    var bgColor: Color
    var title: String
}

var card: [Card] =
[
    Card(bgColor: .red, title: "Red Card"),
    Card(bgColor: .green, title: "Green Card"),
    Card(bgColor: .blue, title: "Blue Card"),
    Card(bgColor: .purple, title: "Purple Card")
]
