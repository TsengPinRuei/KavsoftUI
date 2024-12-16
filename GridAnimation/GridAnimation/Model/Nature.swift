//
//  Nature.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct Nature: Identifiable, Hashable {
    private(set) var id: UUID=UUID.init()
    var title: String
    var image: UIImage?
}

var nature: [Nature]=[
    Nature(title: "Nature 1", image: UIImage(named: "nature1")),
    Nature(title: "Nature 2", image: UIImage(named: "nature2")),
    Nature(title: "Nature 3", image: UIImage(named: "nature3")),
    Nature(title: "Nature 4", image: UIImage(named: "nature4")),
    Nature(title: "Nature 5", image: UIImage(named: "nature5")),
    Nature(title: "Nature 6", image: UIImage(named: "nature6")),
    Nature(title: "Nature 7", image: UIImage(named: "nature7")),
    Nature(title: "Nature 8", image: UIImage(named: "nature8")),
    Nature(title: "Nature 9", image: UIImage(named: "nature9")),
    Nature(title: "Nature 10", image: UIImage(named: "nature10")),
    Nature(title: "Nature 11", image: UIImage(named: "nature11")),
    Nature(title: "Nature 12", image: UIImage(named: "nature12"))
]
