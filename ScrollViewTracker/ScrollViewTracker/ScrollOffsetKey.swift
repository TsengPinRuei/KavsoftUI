//
//  ScrollOffsetKey.swift
//  ScrollViewTracker
//
//  Created by 曾品瑞 on 2023/11/29.
//

import SwiftUI

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat=0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value+=nextValue()
    }
}
