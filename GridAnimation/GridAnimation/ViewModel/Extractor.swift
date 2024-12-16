//
//  Extractor.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct Extractor: UIViewRepresentable {
    var result: (UIScrollView) -> ()
    
    func makeUIView(context: Context) -> some UIView {
        let view: UIView=UIView()
        view.backgroundColor=UIColor.clear
        view.isUserInteractionEnabled=false
        
        DispatchQueue.main.async {
            if let scrollView=view.superview?.superview?.superview as? UIScrollView {
                self.result(scrollView)
            }
        }
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
