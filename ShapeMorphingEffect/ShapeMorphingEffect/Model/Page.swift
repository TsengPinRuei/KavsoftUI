//
//  Page.swift
//  ShapeMorphingEffect
//
//  Created by 曾品瑞 on 2024/10/8.
//

import SwiftUI

enum Page: String, CaseIterable {
    case page1="applewatch"
    case page2="iphone.gen3"
    case page3="ipad.gen2"
    case page4="macbook.gen2"
    
    var title: String {
        switch self {
        case .page1: "Apple Watch"
        case .page2: "iPhone 16 Pro Max"
        case .page3: "iPad Pro 16"
        case .page4: "MacBook Pro 16"
        }
    }
    var subtitle: String {
        switch self {
        case .page1: "National Chung Cheng University"
        case .page2: "Department of Information Systems"
        case .page3: "Chiayi, Taiwan"
        case .page4: "613556005"
        }
    }
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3
        }
    }
    var previous: Page {
        let index: Int=Int(self.index)-1
        
        if(index>=0) {
            return Page.allCases[index]
        } else {
            return self
        }
    }
    var next: Page {
        let index: Int=Int(self.index)+1
        
        if(index<4) {
            return Page.allCases[index]
        } else {
            return self
        }
    }
}
