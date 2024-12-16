//
//  Glitch.swift
//  GlitchTextEffect
//
//  Created by 曾品瑞 on 2024/6/7.
//

import SwiftUI

struct Glitch: Animatable {
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>> {
        get { return AnimatablePair(self.top, AnimatablePair(self.center, AnimatablePair(self.bottom, self.shadow))) }
        set {
            self.top=newValue.first
            self.center=newValue.second.first
            self.bottom=newValue.second.second.first
            self.shadow=newValue.second.second.second
        }
    }
    var top: CGFloat=0
    var center: CGFloat=0
    var bottom: CGFloat=0
    var shadow: CGFloat=0
}
