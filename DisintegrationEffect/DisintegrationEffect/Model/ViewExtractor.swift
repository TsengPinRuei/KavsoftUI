//
//  ViewExtractor.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//

import SwiftUI

struct ViewExtractor: UIViewRepresentable {
    var view: UIView
    
    func makeUIView(context: Context) -> UIView {
        self.view.backgroundColor=UIColor.clear
        return self.view
    }
    func updateUIView(_ uiView: UIView, context: Context) { }
}
