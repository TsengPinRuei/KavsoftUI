//
//  View.swift
//  AppStoreHeroAnimation
//
//  Created by 曾品瑞 on 2024/3/21.
//

import SwiftUI

extension View {
    func offset(offset: Binding<CGFloat>) -> some View {
        return self.overlay {
            GeometryReader {reader in
                let min: CGFloat=reader.frame(in: .named("SCROLL")).minY
                
                Color.clear.preference(key: OffsetKey.self, value: min)
            }
            .onPreferenceChange(OffsetKey.self) {value in
                offset.wrappedValue=value
            }
        }
    }
    func safeArea() -> UIEdgeInsets {
        guard let screen=UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea=screen.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
}
