//
//  Blur.swift
//  BlurView
//
//  Created by 曾品瑞 on 2024/1/10.
//

import SwiftUI

struct Blur<BlurContent: View>: ViewModifier {
    @Binding var show: Bool
    
    let radius: CGFloat
    
    let content: () -> BlurContent
    
    func body(content: Content) -> some View {
        Group {
            content
                .blur(radius: self.show ? self.radius:0)
                .animation(.smooth, value: self.show)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            self.content()
                .opacity(self.show ? 1:0)
                .animation(.smooth, value: self.show)
        }
    }
}
