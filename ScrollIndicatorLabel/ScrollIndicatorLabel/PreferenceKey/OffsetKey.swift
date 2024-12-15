//
//  OffsetKey.swift
//  ScrollIndicatorLabel
//
//  Created by 曾品瑞 on 2023/12/16.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect=CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value=nextValue()
    }
}
