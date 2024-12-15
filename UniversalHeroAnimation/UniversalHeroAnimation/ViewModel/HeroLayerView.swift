//
//  HeroLayerView.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct HeroLayerView: View {
    @EnvironmentObject private var hero: HeroModel
    
    var body: some View {
        GeometryReader { reader in
            ForEach(self.$hero.information) { $information in
                ZStack {
                    if let sourceAnchor=information.sourceAnchor,
                       let destinationAnchor=information.destinationAnchor,
                       let layer=information.layer,
                       !information.hide {
                        let sRect: CGRect=reader[sourceAnchor]
                        let dRect: CGRect=reader[destinationAnchor]
                        let animate: Bool=information.animate
                        let size: CGSize=CGSize(
                            width: animate ? dRect.size.width:sRect.size.width,
                            height: animate ? dRect.size.height:sRect.size.height
                        )
                        let offset: CGSize=CGSize(
                            width: animate ? dRect.minX:sRect.minX,
                            height: animate ? dRect.minY:sRect.minY
                        )
                        
                        layer
                            .frame(width: size.width, height: size.height)
                            .clipShape(.rect(cornerRadius: animate ? information.destinationRadius:information.sourceRadius))
                            .offset(offset)
                            .transition(.identity)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
                .onChange(value: information.animate) { value in
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.45) {
                        if(!value) {
                            information.active=false
                            information.layer=nil
                            information.sourceAnchor=nil
                            information.destinationAnchor=nil
                            information.sourceRadius=0
                            information.destinationRadius=0
                            information.completion(false)
                        } else {
                            information.hide=true
                            information.completion(true)
                        }
                    }
                }
            }
        }
    }
}
