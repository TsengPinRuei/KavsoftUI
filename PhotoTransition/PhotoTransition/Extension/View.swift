//
//  View.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/13.
//

import SwiftUI

extension View {
    @ViewBuilder
    func frameChange(result: @escaping (CGRect, CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let frame: CGRect=$0.frame(in: .scrollView(axis: .vertical))
                    let bounds: CGRect=$0.bounds(of: .scrollView(axis: .vertical)) ?? .zero
                    
                    Color.clear
                        .preference(key: FrameKey.self, value: ViewFrame(frame: frame, bounds: bounds))
                        .onPreferenceChange(FrameKey.self) {value in
                            result(value.frame, value.bounds)
                        }
                }
            }
    }
}
