//
//  Like.swift
//  InstagramReels
//
//  Created by 曾品瑞 on 2023/11/14.
//

import SwiftUI

struct Like: Identifiable {
    var id: UUID=UUID()
    var tap: CGPoint = .zero
    var animate: Bool=false
}
