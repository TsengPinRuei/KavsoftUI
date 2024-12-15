//
//  Item.swift
//  ComplexScrollAnimation
//
//  Created by 曾品瑞 on 2023/11/6.
//

import Foundation

struct Item: Identifiable {
    var id: UUID=UUID()
    var amount: String
    var product: String
    var type: String
}

var item: [Item] =
[
    Item(amount: "$1", product: "Baloon", type: "Relationship"),
    Item(amount: "$5", product: "Flower", type: "Relationship"),
    Item(amount: "$100", product: "Bag", type: "Relationship"),
    Item(amount: "$199", product: "Jacket", type: "Relationship"),
    Item(amount: "$10", product: "YouTube Premium", type: "Stream"),
    Item(amount: "$15", product: "Netflix", type: "Stream"),
    Item(amount: "$15", product: "Disney+", type: "Stream"),
    Item(amount: "$99", product: "Magic Keyboard", type: "Product"),
    Item(amount: "$89", product: "Magic Mouse", type: "Product"),
    Item(amount: "$9", product: "Kavsoft", type: "Pro Member"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null"),
    Item(amount: "$0", product: "Null", type: "Null")
]
