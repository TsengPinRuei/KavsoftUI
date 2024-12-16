//
//  KeyRenderer.swift
//  TextRenderer
//
//  Created by 曾品瑞 on 2024/9/20.
//

import Foundation
import SwiftUI

struct KeyRenderer: TextRenderer, Animatable {
    enum RendererType: String, CaseIterable {
        case blur="Blur"
        case pixellate="Pixellate"
    }
    
    var animatableData: CGFloat {
        get { self.progress }
        set { self.progress=newValue }
    }
    var progress: CGFloat
    var type: RendererType=RendererType.blur
    
    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let line=layout.flatMap({ $0 })
        
        for i in line {
            if let _=i[KeyAttribute.self] {
                let isBlur: Bool=self.type==RendererType.blur
                let blurProgress: CGFloat=5-(5*self.progress)
                let pixellateProgress: CGFloat=5-(4.999*self.progress)
                var context: GraphicsContext=ctx
                let blurFilter: GraphicsContext.Filter=GraphicsContext.Filter.blur(radius: blurProgress)
                let pixellateFilter: GraphicsContext.Filter=GraphicsContext.Filter.distortionShader(ShaderLibrary.pixellate(.float(pixellateProgress)), maxSampleOffset: .zero)
                
                
                context.addFilter(isBlur ? blurFilter:pixellateFilter)
                context.draw(i)
            } else {
                var context: GraphicsContext=ctx
                context.draw(i)
            }
        }
    }
}
