//
//  PassWindow.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

class PassWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hit: UIView=super.hitTest(point, with: event), let root: UIView=rootViewController?.view else { return nil }
        
        if #available(iOS 18, *) {
            for view in root.subviews.reversed() {
                let point=view.convert(point, from: root)
                
                if(view.hitTest(point, with: event) != nil) {
                    return hit
                }
            }
            return nil
        } else {
            return hit==root ? nil:hit
        }
    }
}
