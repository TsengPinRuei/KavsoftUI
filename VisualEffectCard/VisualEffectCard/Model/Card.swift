//
//  Card.swift
//  VisualEffectCard
//
//  Created by 曾品瑞 on 2024/3/12.
//

import SwiftUI

extension [Card] {
    func zIndex(_ card: Card) -> CGFloat {
        if let index=firstIndex(where: { $0.id==card.id }) {
            return CGFloat(count)-CGFloat(index)
        } else {
            return CGFloat.zero
        }
    }
}

struct Card: Identifiable {
    var id: UUID=UUID()
    var color: Color
}

var card: [Card]=[
    Card(color: .red),
    Card(color: .orange),
    Card(color: .yellow),
    Card(color: .green),
    Card(color: .blue),
    Card(color: .purple),
    Card(color: .black)
]
