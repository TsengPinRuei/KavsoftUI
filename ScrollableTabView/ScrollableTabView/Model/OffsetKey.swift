//
//  OffsetKey.swift
//  ScrollableTabView
//
//  Created by 曾品瑞 on 2023/11/9.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value=nextValue()
    }
}
