//
//  CustomScrollBehavior.swift
//  ComplexScrollCalendar
//
//  Created by 曾品瑞 on 2023/11/18.
//

import SwiftUI

struct CustomScrollBehavior: ScrollTargetBehavior {
    var height: CGFloat
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if(target.rect.minY<self.height) {
            target.rect = .zero
        }
    }
}
