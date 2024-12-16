//
//  View.swift
//  YouTubePlayerAnimation
//
//  Created by 曾品瑞 on 2024/3/11.
//

import SwiftUI

extension View {
    var tabBarHeight: CGFloat { return 50+self.safeArea.bottom }
    var safeArea: UIEdgeInsets {
        if let safe=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safe
        } else {
            return .zero
        }
    }
    
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
