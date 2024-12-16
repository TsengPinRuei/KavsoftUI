//
//  TextAction.swift
//  TextFieldMenuAction
//
//  Created by 曾品瑞 on 2024/11/14.
//

import SwiftUI

struct TextAction {
    var title: String
    var action: (NSRange, UITextField) -> ()
}
