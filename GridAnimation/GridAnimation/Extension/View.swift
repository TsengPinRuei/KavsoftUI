//
//  View.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

extension View {
    var safeArea: UIEdgeInsets {
        if let safeArea=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    @ViewBuilder
    func offsetY(result: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minY: CGFloat=$0.frame(in: .scrollView(axis: .vertical)).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) {value in
                            result(value)
                        }
                }
            }
    }
}
