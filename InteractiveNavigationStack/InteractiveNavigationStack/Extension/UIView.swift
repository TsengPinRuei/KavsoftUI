//
//  UIView.swift
//  InteractiveNavigationStack
//
//  Created by 曾品瑞 on 2023/10/25.
//

import SwiftUI

extension UIView {
    var parentViewController: UIViewController? {
        sequence(first: self) { $0.next }
            .first(where: { $0 is UIViewController }) as? UIViewController
    }
}
