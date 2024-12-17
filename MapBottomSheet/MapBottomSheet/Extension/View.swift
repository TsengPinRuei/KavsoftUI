//
//  View.swift
//  MapBottomSheet
//
//  Created by 曾品瑞 on 2024/3/4.
//

import SwiftUI

extension View {
    @ViewBuilder
    func bottomMask(mask: Bool=true, _ height: CGFloat=50) -> some View {
        self.background(SheetRootView(mask: mask, height: height))
    }
}

fileprivate struct SheetRootView: UIViewRepresentable {
    var mask: Bool
    var height: CGFloat
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            if let rootView=uiView.beforeWindowView,
               let window=rootView.window {
                let safeArea: UIEdgeInsets=window.safeAreaInsets
                rootView.frame=CGRect(origin: .zero, size: CGSize(width: window.frame.width, height: window.frame.height-(self.mask ? (self.height+safeArea.bottom):0)))
                rootView.clipsToBounds=true
                
                for i in rootView.subviews {
                    i.layer.shadowColor=UIColor.clear.cgColor
                    
                    if(i.layer.animationKeys() != nil) {
                        if let radiusView=i.subView.first(where: { $0.layer.animationKeys()?.contains("cornerRadius") ?? false }) {
                            radiusView.layer.maskedCorners=[]
                        }
                    }
                }
            }
        }
    }
}
