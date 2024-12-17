//
//  OffsetKey.swift
//  AppStoreHeroAnimation
//
//  Created by 曾品瑞 on 2024/3/21.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat=0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value=nextValue()
    }
}
