//
//  TextField.swift
//  TextFieldMenuAction
//
//  Created by 曾品瑞 on 2024/11/14.
//

import SwiftUI

extension TextField {
    @ViewBuilder
    func menu(show: Bool, @TextActionBuilder action: @escaping () -> [TextAction]) -> some View {
        self
            .background(TextActionView(show: show, action: action()))
            .compositingGroup()
    }
}
