//
//  BottomTab.swift
//  MapBottomSheet
//
//  Created by 曾品瑞 on 2024/3/4.
//

import SwiftUI

enum BottomTab: String, CaseIterable {
    case people="People"
    case device="Device"
    case item="Item"
    case me="Me"
    
    var symbol: String {
        switch(self) {
        case .people: "figure.2.arms.open"
        case .device: "macbook.and.iphone"
        case .item: "circle.grid.2x2.fill"
        case .me: "person.circle.fill"
        }
    }
}
