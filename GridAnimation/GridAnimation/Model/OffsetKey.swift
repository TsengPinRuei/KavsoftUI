//
//  OffsetKey.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat=CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value=nextValue()
    }
}
