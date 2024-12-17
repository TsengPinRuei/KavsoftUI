//
//  ScaleButtonStyle.swift
//  AppStoreHeroAnimation
//
//  Created by 曾品瑞 on 2024/3/20.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.9:1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
