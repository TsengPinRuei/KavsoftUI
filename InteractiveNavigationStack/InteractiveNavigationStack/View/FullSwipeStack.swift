//
//  FullSwipeStack.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

struct FullSwipeStack<Content: View>: View {
    @State private var gesture: UIPanGestureRecognizer = {
        let gesture=UIPanGestureRecognizer()
        gesture.name=UUID().uuidString
        gesture.isEnabled=false
        return gesture
    }()
    
    @ViewBuilder var content: Content
    
    var body: some View {
        NavigationStack {
            self.content
                .background {
                    GestureView(gesture: self.$gesture)
                }
        }
        .environment(\.popGestureID, self.gesture.name)
        .onReceive(NotificationCenter.default.publisher(for: .init(self.gesture.name ?? ""))) {information in
            if let user=information.userInfo,
               let status=user["status"] as? Bool {
                self.gesture.isEnabled=status
            }
        }
    }
}
