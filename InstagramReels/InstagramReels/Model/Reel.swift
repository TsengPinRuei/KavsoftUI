//
//  Reel.swift
//  InstagramReels
//
//  Created by 曾品瑞 on 2023/11/14.
//

import SwiftUI

struct Reel: Identifiable {
    var id: UUID=UUID()
    var name: String
    var author: String
    var like: Bool=false
}

var reel: [Reel]=[
    Reel(name: "Reel1", author: "Justin"),
    Reel(name: "Reel2", author: "Justin"),
    Reel(name: "Reel3", author: "Wendy"),
    Reel(name: "Reel4", author: "Wendy")
]
