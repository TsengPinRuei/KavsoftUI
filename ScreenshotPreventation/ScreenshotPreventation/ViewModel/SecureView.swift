//
//  SecureView.swift
//  ScreenshotPreventation
//
//  Created by 曾品瑞 on 2024/1/7.
//

import SwiftUI

struct SecureView<Content: View>: UIViewControllerRepresentable {
    private var prevent: Bool
    private let content: () -> Content
    
    init(prevent: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.prevent=prevent
        self.content=content
    }
    
    func makeUIViewController(context: Context) -> SecureViewController<Content> {
        SecureViewController(prevent: self.prevent, content: self.content)
    }
    func updateUIViewController(_ uiViewController: SecureViewController<Content>, context: Context) {
        uiViewController.prevent=self.prevent
    }
}
