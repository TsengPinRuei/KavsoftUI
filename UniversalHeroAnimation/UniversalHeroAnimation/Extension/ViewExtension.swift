//
//  ViewExtension.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

extension View {
    @ViewBuilder
    func heroLayer<Content: View>(
        id: String,
        animate: Binding<Bool>,
        sourceRadius: CGFloat=0,
        destinationRadius: CGFloat=0,
        @ViewBuilder content: @escaping () -> Content,
        completion: @escaping (Bool) -> ()
    ) -> some View {
        self
            .modifier(
                HeroLayerViewModifier(
                    id: id,
                    animate: animate,
                    sourceRadius: sourceRadius,
                    destinationRadius: destinationRadius,
                    layer: content,
                    completion: completion
                )
            )
    }
    @ViewBuilder
    func onChange<Value: Equatable>(value: Value, completion: @escaping (Value) -> ()) -> some View {
        self
            .onChange(of: value) { (_, new) in
                completion(new)
            }
    }
}
