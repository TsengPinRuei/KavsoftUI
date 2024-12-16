//
//  View.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    func universal<Content: View>(
        animation: Animation=Animation.snappy,
        show: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(UniversalModifier(animation: animation, show: show, content: content))
    }
}
