//
//  GlitchBuilder.swift
//  GlitchTextEffect
//
//  Created by 曾品瑞 on 2024/6/7.
//

import SwiftUI

@resultBuilder
struct GlitchBuilder {
    static func buildBlock(_ components: LinearKeyframe<Glitch>...) -> [LinearKeyframe<Glitch>] {
        return components
    }
}
