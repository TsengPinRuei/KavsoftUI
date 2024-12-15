//
//  View.swift
//  AutoOTP
//
//  Created by 曾品瑞 on 2023/11/13.
//

import SwiftUI

extension View {
    func disableWithOpacity(_ disable: Bool) -> some View {
        self
            .disabled(disable)
            .opacity(disable ? 0.5:1)
            .animation(.smooth, value: disable)
    }
}
