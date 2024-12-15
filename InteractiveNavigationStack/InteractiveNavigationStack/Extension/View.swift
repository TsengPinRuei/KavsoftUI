//
//  View.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func fullSwipeDismiss(_ isEnabled: Bool) -> some View {
        self.modifier(FullSwipeModifier(isEnabled: isEnabled))
    }
}
