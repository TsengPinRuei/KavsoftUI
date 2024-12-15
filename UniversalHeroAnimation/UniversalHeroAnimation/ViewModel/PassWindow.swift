//
//  PassWindow.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

class PassWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view=super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view==view ? nil:view
    }
}
