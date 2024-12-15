//
//  Profile.swift
//  ProgressBasedHeroAnimation
//
//  Created by 曾品瑞 on 2023/10/17.
//

import Foundation

struct Profile: Identifiable {
    var id: UUID=UUID()
    var name: String
    var picture: String
    var message: String
}

var person: [Profile] = [
    Profile(name: "Justin", picture: "Patrick", message: "I am Justin"),
    Profile(name: "Wendy", picture: "Patrick", message: "I am Wendy"),
    Profile(name: "A", picture: "Patrick", message: "I am A"),
    Profile(name: "B", picture: "Patrick", message: "I am B"),
    Profile(name: "C", picture: "Patrick", message: "I am C")
]
