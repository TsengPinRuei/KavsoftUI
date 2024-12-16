//
//  RectKey.swift
//  ScrollTabBar
//
//  Created by 曾品瑞 on 2024/4/24.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect=CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value=nextValue()
    }
}
