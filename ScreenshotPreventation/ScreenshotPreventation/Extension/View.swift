//
//  View.swift
//  ScreenshotPreventation
//
//  Created by 曾品瑞 on 2024/1/7.
//

import SwiftUI

extension View {
    func preventScreenshot(protect: Bool) -> some View {
        modifier(PreventScreenshot(protect: protect))
    }
}
