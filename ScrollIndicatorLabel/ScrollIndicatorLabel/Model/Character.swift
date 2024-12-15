//
//  Character.swift
//  ScrollIndicatorLabel
//
//  Created by 曾品瑞 on 2023/12/16.
//

import SwiftUI

struct Character: Identifiable {
    var id: String=UUID().uuidString
    var value: String
    var index: Int=0
    var rect: CGRect=CGRect.zero
    var offset: CGFloat=0
    var current: Bool=false
    var color: Color=Color.clear
}
