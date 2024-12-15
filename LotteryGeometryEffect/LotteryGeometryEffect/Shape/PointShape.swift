//
//  PointShape.swift
//  LotteryGeometryEffect
//
//  Created by 曾品瑞 on 2023/12/13.
//

import SwiftUI

struct PointShape: Shape {
    var point: [CGPoint]
    var animatableData: [CGPoint] {
        get { self.point }
        set { self.point=newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path {path in
            if let first=self.point.first {
                path.move(to: first)
                path.addLines(self.point)
            }
        }
    }
}
