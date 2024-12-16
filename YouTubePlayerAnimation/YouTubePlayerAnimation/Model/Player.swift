//
//  Player.swift
//  YouTubePlayerAnimation
//
//  Created by 曾品瑞 on 2024/3/11.
//

import SwiftUI

let description: String="DESCRIPTION"

struct Player: Identifiable, Equatable {
    let id: UUID=UUID()
    var title: String
    var author: String
    var image: String
    var description: String=YouTubePlayerAnimation.description
}

var player: [Player]=[
    Player(title: "iPhone 15 Pro Max !!!", author: "Justin", image: "iPhone15ProMax"),
    Player(title: "AirPods Pro 2 !!!", author: "Justin", image: "AirPodsPro2"),
    Player(title: "Apple Vision Pro !!!", author: "Justin", image: "VisionPro"),
    Player(title: "SwiftUI Introduction !!!", author: "Justin", image: "SwiftUI"),
    Player(title: "Welcome To Chung Chung University !!!", author: "CCU", image: "CCU")
]
