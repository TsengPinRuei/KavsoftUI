//
//  GlitchView.swift
//  GlitchTextEffect
//
//  Created by 曾品瑞 on 2024/6/7.
//

import SwiftUI

struct GlitchView: View {
    var glitch: Bool
    var text: String
    var shadow: Color
    var radius: CGFloat
    var frame: [LinearKeyframe<Glitch>]
    
    init(glitch: Bool, text: String, shadow: Color=Color.red, radius: CGFloat=1, @GlitchBuilder frame: @escaping () -> [LinearKeyframe<Glitch>]) {
        self.glitch=glitch
        self.text=text
        self.shadow=shadow
        self.radius=radius
        self.frame=frame()
    }
    
    @ViewBuilder
    private func SpacerView() -> some View {
        Spacer(minLength: 0).frame(maxHeight: .infinity)
    }
    @ViewBuilder
    private func TextView(_ alignment: Alignment, offset: CGFloat, opacity: CGFloat) -> some View {
        Text(self.text)
            .multilineTextAlignment(.center)
            .mask {
                if(alignment==Alignment.top) {
                    VStack(spacing: 0) {
                        Rectangle()
                        
                        self.SpacerView()
                        
                        self.SpacerView()
                    }
                } else if(alignment==Alignment.center) {
                    VStack(spacing: 0) {
                        self.SpacerView()
                        
                        Rectangle()
                        
                        self.SpacerView()
                    }
                } else {
                    VStack(spacing: 0) {
                        self.SpacerView()
                        
                        self.SpacerView()
                        
                        Rectangle()
                    }
                }
            }
            .shadow(color: self.shadow.opacity(opacity), radius: self.radius, x: offset, y: offset/2)
            .offset(x: offset)
    }
    
    var body: some View {
        KeyframeAnimator(initialValue: Glitch(), trigger: self.glitch) {value in
            ZStack {
                self.TextView(.top, offset: value.top, opacity: value.shadow)
                self.TextView(.center, offset: value.center, opacity: value.shadow)
                self.TextView(.bottom, offset: value.bottom, opacity: value.shadow)
            }
            .compositingGroup()
        } keyframes: {_ in
            for i in self.frame { i }
        }
    }
}
