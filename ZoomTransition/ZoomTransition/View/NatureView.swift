//
//  NatureView.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI

struct NatureView: View {
    @Binding var nature: Nature
    
    @Environment(NatureModel.self) private var model
    
    var size: CGSize
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            if let image=self.nature.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .clipShape(.rect(cornerRadius: 20))
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.fill)
                    .task(priority: .high) {
                        await self.model.generateNature(self.$nature, size: self.size)
                    }
            }
        }
    }
}
