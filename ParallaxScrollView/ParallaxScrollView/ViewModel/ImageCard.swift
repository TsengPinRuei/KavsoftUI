//
//  ImageCard.swift
//  ParallaxScrollView
//
//  Created by 曾品瑞 on 2023/11/30.
//

import SwiftUI

struct ImageCard: View {
    var card: Card=ParallaxScrollView.card[0]
    var namespace: Namespace.ID
    
    @Binding var show: Bool
    @Binding var width: CGFloat
    
    var body: some View {
        GeometryReader {reader in
            let offset: CGFloat=(reader.frame(in: .global).maxX-UIScreen.main.bounds.midX)/3
            
            VStack {
                Spacer()
                
                Text(self.card.text)
                    .bold()
                    .font(.title)
                    .matchedGeometryEffect(id: "title\(self.card.id)", in: self.namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .background {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background {
                Image(self.card.name)
                    .resizable()
                    .scaledToFill()
                    .matchedGeometryEffect(id: "image\(self.card.id)", in: self.namespace)
                    .offset(x: offset)
            }
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous).matchedGeometryEffect(id: "mask\(self.card.id)", in: self.namespace))
            .frame(width: self.width, height: 500)
        }
    }
}
