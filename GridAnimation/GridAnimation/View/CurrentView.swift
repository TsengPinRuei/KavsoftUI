//
//  CurrentView.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct CurrentView: View {
    var nature: Nature
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            if let image=self.nature.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .clipped()
            }
        }
    }
}
