//
//  Post.swift
//  SynchronizedHeroAnimation
//
//  Created by 曾品瑞 on 2023/12/7.
//

import Foundation

struct Post: Identifiable {
    let id: UUID=UUID()
    var name: String
    var content: String
    var landscape: [Landscape]
    var scrollPostiion: UUID?
}

var landscape: [Landscape]=(1...5).compactMap {index -> Landscape? in
    return Landscape(image: "landscape\(index)")
}
var landscapeR: [Landscape]=(1...5).reversed().compactMap {index -> Landscape? in
    return Landscape(image: "landscape\(index)")
}
var post: [Post]=[
    Post(name: "Justin", content: "Landscape", landscape: SynchronizedHeroAnimation.landscape),
    Post(name: "Wendy", content: "Reversed Landscape", landscape: SynchronizedHeroAnimation.landscapeR)
]
