//
//  CustomScrollBehavior.swift
//  ComplexScrollAnimation
//
//  Created by 曾品瑞 on 2023/11/6.
//

import SwiftUI

struct CustomScrollBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if(target.rect.minY<76) {
            target.rect = .zero
        }
    }
}
