//
//  UIView.swift
//  MapBottomSheet
//
//  Created by 曾品瑞 on 2024/3/4.
//

import SwiftUI

extension UIView {
    var beforeWindowView: UIView? {
        if let superview, superview is UIWindow {
            return self
        } else {
            return superview?.beforeWindowView
        }
    }
    
    var subView: [UIView] {
        return subviews.flatMap { [$0]+$0.subviews }
    }
}
