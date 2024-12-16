//
//  View.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//

import SwiftUI

extension View {
    @ViewBuilder
    func disintegration(delete: Bool, completion: @escaping () -> ()) -> some View {
        self.modifier(DisintegrationEffect(delete: delete, completion: completion))
    }
    
    func snapshot(shot: Bool, complete: @escaping (UIImage) -> ()) -> some View {
        self.modifier(Snapshot(shot: shot, complete: complete))
    }
}
