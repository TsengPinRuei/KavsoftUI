//
//  HeroView.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/12.
//

import SwiftUI

struct HeroView: View {
    @Environment(UICoordinator.self) private var coordinator
    
    var nature: Nature
    var start: Anchor<CGRect>
    var end: Anchor<CGRect>
    
    var body: some View {
        GeometryReader {reader in
            let animate: Bool=self.coordinator.animate
            let start: CGRect=reader[self.start]
            let end: CGRect=reader[self.end]
            let size: CGSize=CGSize(width: animate ? end.width:start.width, height: animate ? end.height:start.height)
            let position: CGSize=CGSize(width: animate ? end.minX:start.minX, height: animate ? end.minY:start.minY)
            
            if let image=self.nature.image, !self.coordinator.show {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: animate ? .fit:.fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .offset(position)
                    .transition(.identity)
            }
        }
    }
}
