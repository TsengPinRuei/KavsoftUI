//
//  OffsetKey.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/11.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat=0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value=nextValue()
    }
}
