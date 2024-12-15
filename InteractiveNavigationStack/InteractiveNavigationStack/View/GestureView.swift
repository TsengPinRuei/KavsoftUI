//
//  GestureView.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

struct GestureView: UIViewRepresentable {
    @Binding var gesture: UIPanGestureRecognizer
    
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.02) {
            if let parent=uiView.parentViewController {
                if let navigation=parent.navigationController {
                    if let _=navigation.view.gestureRecognizers?.first(where: { $0.name==self.gesture.name }) {
                        
                    } else {
                        navigation.fullSwipeGesture(self.gesture)
                    }
                }
            }
        }
    }
}
