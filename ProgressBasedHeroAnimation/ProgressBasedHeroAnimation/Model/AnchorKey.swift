//
//  AnchorKey.swift
//  ProgressBasedHeroAnimation
//
//  Created by 曾品瑞 on 2023/10/17.
//

import SwiftUI

struct AnchorKey: PreferenceKey {
    static var defaultValue: [String:Anchor<CGRect>]=[:]
    
    static func reduce(value: inout [String:Anchor<CGRect>], nextValue: () -> [String:Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
