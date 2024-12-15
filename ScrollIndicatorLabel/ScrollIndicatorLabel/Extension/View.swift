//
//  View.swift
//  ScrollIndicatorLabel
//
//  Created by 曾品瑞 on 2023/12/16.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetForRL(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {reader in
                    let rect: CGRect=reader.frame(in: .named("SCROLLER"))
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self) {value in
                            completion(value)
                        }
                }
            }
    }
    @ViewBuilder
    func offsetForNL(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect: CGRect=$0.frame(in: .named("SCROLLER"))
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: rect)
                        .onPreferenceChange(OffsetKey.self) {value in
                            completion(value)
                        }
                }
            }
    }
}
