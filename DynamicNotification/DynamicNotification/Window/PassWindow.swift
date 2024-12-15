//
//  PassWindow.swift
//  DynamicNotification
//
//  Created by 曾品瑞 on 2023/10/27.
//

import SwiftUI

class PassWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view=super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view==view ? nil:view
    }
}
