//
//  View.swift
//  CoverFlow
//
//  Created by 曾品瑞 on 2024/1/17.
//

import SwiftUI

extension View {
    @ViewBuilder
    func reflection(_ add: Bool, count: Int) -> some View {
        self
            .overlay {
                if(add) {
                    GeometryReader {
                        let size=$0.size
                        
                        self
                            .scaleEffect(y: -1)
                            .mask {
                                Rectangle()
                                    .fill(
                                        .linearGradient(
                                            colors: [
                                                .white,
                                                .white.opacity(0.7),
                                                .white.opacity(0.5),
                                                .white.opacity(0.3),
                                                .white.opacity(0.1),
                                                .white.opacity(0),
                                            ]+Array(repeating: .clear, count: count),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                            }
                            .offset(y: size.height+5)
                            .opacity(0.5)
                            .transition(.opacity.animation(.smooth))
                    }
                }
            }
    }
}
