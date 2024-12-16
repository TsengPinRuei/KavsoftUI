//
//  SearchTarget.swift
//  NavigationSearchBar
//
//  Created by 曾品瑞 on 2024/4/30.
//

import SwiftUI

struct SearchTarget: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if(target.rect.minY<70) {
            target.rect.origin=target.rect.minY<35 ? CGPoint.zero:CGPoint(x: 0, y: 70)
        }
    }
}
