//
//  TabBar.swift
//  ScrollTabBar
//
//  Created by 曾品瑞 on 2024/4/24.
//

import SwiftUI

struct TabBar: Identifiable {
    enum Tab: String, CaseIterable {
        case you="For You"
        case all="All"
        case follow="Following"
        case topic="Topic"
        case ccu="National Chung Cheng University"
    }
    
    private(set) var id: Tab
    var size: CGSize=CGSize.zero
    var min: CGFloat=CGFloat.zero
}
