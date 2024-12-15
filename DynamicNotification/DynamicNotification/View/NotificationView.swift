//
//  NotificationView.swift
//  DynamicNotification
//
//  Created by 曾品瑞 on 2023/10/27.
//

import SwiftUI

struct NotificationView<Content: View>: View {
    @State private var animateNotification: Bool=false
    
    var content: Content
    var safeArea: UIEdgeInsets
    var tag: Int
    var dynamicIsland: Bool
    var timeout: CGFloat
    var swipeToDismiss: Bool
    var y: CGFloat {
        if(self.dynamicIsland) {
            return 0
        } else {
            return self.animateNotification ? 10:-(self.safeArea.top+130)
        }
    }
    
    private func removeNotification() {
        if let window=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag==0320 }) {
            if let view=window.viewWithTag(self.tag) {
                view.removeFromSuperview()
                if let controller=window.rootViewController as? StatusBarController,
                   controller.view.subviews.isEmpty {
                    controller.statusBarStyle = .default
                    controller.setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
    }
    
    var body: some View {
        self.content
            .blur(radius: self.animateNotification ? 0:10)
            .disabled(!self.animateNotification)
            .mask {
                if(self.dynamicIsland) {
                    GeometryReader {reader in
                        let size=reader.size
                        let radius=size.height/2
                        
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                    }
                } else {
                    Rectangle()
                }
            }
            .scaleEffect(self.dynamicIsland ? (self.animateNotification ? 1:0.01):1, anchor: UnitPoint(x: 0.5, y: 0.01))
            .offset(y: self.y)
            .gesture(
                DragGesture()
                    .onEnded {value in
                        if(-value.translation.height>50 && self.swipeToDismiss) {
                            withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                                self.animateNotification=false
                            } completion: {
                                self.removeNotification()
                            }
                        }
                    }
            )
            .onAppear {
                Task {
                    guard !self.animateNotification else { return }
                    withAnimation(.smooth) {
                        self.animateNotification=true
                    }
                    try await Task.sleep(for: .seconds(self.timeout<1 ? 1:self.timeout))
                    
                    guard self.animateNotification else { return }
                    withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                        self.animateNotification=false
                    } completion: {
                        
                    }
                }
            }
    }
}
