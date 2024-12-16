//
//  FrameKey.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/13.
//

import SwiftUI

struct FrameKey: PreferenceKey {
    static var defaultValue: ViewFrame=ViewFrame()
    
    static func reduce(value: inout ViewFrame, nextValue: () -> ViewFrame) {
        value=nextValue()
    }
}
