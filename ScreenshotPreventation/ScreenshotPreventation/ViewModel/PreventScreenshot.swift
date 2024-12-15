//
//  PreventScreenshot.swift
//  ScreenshotPreventation
//
//  Created by 曾品瑞 on 2024/1/7.
//

import SwiftUI

public struct PreventScreenshot: ViewModifier {
    public let protect: Bool
    
    public func body(content: Content) -> some View {
        SecureView(prevent: self.protect) {
            content
        }
    }
}
