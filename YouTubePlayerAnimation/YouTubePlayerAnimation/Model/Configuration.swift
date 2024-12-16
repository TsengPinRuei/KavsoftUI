//
//  Configuration.swift
//  YouTubePlayerAnimation
//
//  Created by 曾品瑞 on 2024/3/11.
//

import SwiftUI

struct Configuration: Equatable {
    var show: Bool=false
    var current: CGFloat=CGFloat.zero
    var end: CGFloat=CGFloat.zero
    var progress: CGFloat=CGFloat.zero
    var select: Player?
    
    mutating func reset() {
        self.current=CGFloat.zero
        self.end=CGFloat.zero
        self.progress=CGFloat.zero
    }
}
