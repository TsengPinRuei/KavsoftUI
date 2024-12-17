//
//  Today.swift
//  AppStoreHeroAnimation
//
//  Created by 曾品瑞 on 2024/3/20.
//

import SwiftUI

struct Today: Identifiable {
    var id: String=UUID().uuidString
    var name: String
    var description: String
    var logo: String
    var title: String
    var platform: String
    var work: String
}

var today: [Today]=[
    Today(
        name: "CCU",
        description: "The only national university without an N in its name.",
        logo: "CCU",
        title: "Welcome to National Chung Cheng University!",
        platform: "National Chung Cheng University",
        work: "CCUSchool"
    ),
    Today(
        name: "NCCU",
        description: "Poor CCU.",
        logo: "NCCU",
        title: "Welcome to National Cheng Chi University!",
        platform: "National Cheng Chi University",
        work: "NCCUSchool"
    ),
]
