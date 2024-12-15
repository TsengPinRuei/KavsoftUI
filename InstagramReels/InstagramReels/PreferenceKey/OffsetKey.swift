//
//  OffsetKey.swift
//  InstagramReels
//
//  Created by 曾品瑞 on 2023/11/14.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value=nextValue()
    }
}
