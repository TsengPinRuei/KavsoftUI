//
//  UINavigationController.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

extension UINavigationController {
    func fullSwipeGesture(_ gesture: UIPanGestureRecognizer) {
        guard let select=interactivePopGestureRecognizer?.value(forKey: "targets") else { return }
        
        gesture.setValue(select, forKey: "targets")
        view.addGestureRecognizer(gesture)
    }
}
