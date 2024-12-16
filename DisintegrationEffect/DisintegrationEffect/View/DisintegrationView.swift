//
//  DisintegrationView.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//

import SwiftUI

struct DisintegrationView: View {
    @Binding var particle: [Particle]
    @Binding var animate: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach(self.particle) { particle in
                Image(uiImage: particle.image)
                    .offset(particle.offset)
                    .offset(
                        x: self.animate ? .random(in: -100...(-50)):0,
                        y: self.animate ? .random(in: -100...(-50)):0
                    )
                    .opacity(self.animate ? 0:1)
            }
        }
        .compositingGroup()
        .blur(radius: self.animate ? 5:0)
    }
}
