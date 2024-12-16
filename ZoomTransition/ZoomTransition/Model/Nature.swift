//
//  Nature.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI

struct Nature: Identifiable, Hashable {
    var id: UUID=UUID()
    var url: URL
    var image: UIImage?
}

let nature: [Nature]=[
    URL(filePath: Bundle.main.path(forResource: "nature1", ofType: "mp4") ?? ""),
    URL(filePath: Bundle.main.path(forResource: "nature2", ofType: "mp4") ?? ""),
    URL(filePath: Bundle.main.path(forResource: "nature3", ofType: "mp4") ?? ""),
    URL(filePath: Bundle.main.path(forResource: "nature4", ofType: "mp4") ?? ""),
    URL(filePath: Bundle.main.path(forResource: "nature5", ofType: "mp4") ?? ""),
    URL(filePath: Bundle.main.path(forResource: "nature6", ofType: "mp4") ?? "")
].compactMap({ Nature(url: $0) })
