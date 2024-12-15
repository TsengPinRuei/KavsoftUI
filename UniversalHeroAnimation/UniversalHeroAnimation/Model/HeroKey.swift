//
//  HeroKey.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct HeroKey: PreferenceKey {
    static var defaultValue: [String:Anchor<CGRect>]=[:]
    static func reduce(value: inout [String:Anchor<CGRect>], nextValue: () -> [String:Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
