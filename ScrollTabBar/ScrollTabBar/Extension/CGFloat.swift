//
//  CGFloat.swift
//  ScrollTabBar
//
//  Created by 曾品瑞 on 2024/4/24.
//

import SwiftUI

extension CGFloat {
    func interpolate(input: [CGFloat], output: [CGFloat]) -> CGFloat {
        let x: CGFloat=self
        let length: Int=input.count-1
        
        if(x<=input[0]) {
            return output[0]
        } else {
            for i in 1...length {
                let x1: CGFloat=input[i-1]
                let x2: CGFloat=input[i]
                let y1: CGFloat=output[i-1]
                let y2: CGFloat=output[i]
                
                if(x<=input[i]) {
                    return y1+((y2-y1)/(x2-x1))*(x-x1)
                }
            }
            return output[length]
        }
    }
}
