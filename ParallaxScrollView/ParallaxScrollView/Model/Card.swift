//
//  Card.swift
//  ParallaxScrollView
//
//  Created by 曾品瑞 on 2023/11/30.
//

import SwiftUI

struct Card: Identifiable {
    var id: UUID=UUID()
    var name: String
    var text: String
}

var card: [Card]=[
    Card(name: "city", text: "City"),
    Card(name: "mountain", text: "Mountain"),
    Card(name: "ocean", text: "Ocean"),
    Card(name: "river", text: "River")
]
