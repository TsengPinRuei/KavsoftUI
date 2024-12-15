//
//  FullSwipeModifier.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

struct FullSwipeModifier: ViewModifier {
    @Environment(\.popGestureID) private var gestureID
    
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .onChange(of: self.isEnabled, initial: true) {(old, new) in
                guard let gestureID=self.gestureID else { return }
                
                NotificationCenter.default.post(name: .init(gestureID), object: nil, userInfo: ["status":new])
            }
            .onDisappear {
                guard let gestureID=self.gestureID else { return }
                
                NotificationCenter.default.post(name: .init(gestureID), object: nil, userInfo: ["status":false])
            }
    }
}
