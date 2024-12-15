//
//  ImageDetail.swift
//  ParallaxScrollView
//
//  Created by 曾品瑞 on 2023/11/30.
//

import SwiftUI

struct ImageDetail: View {
    @State private var showText: Bool=false
    
    var namespace: Namespace.ID
    var card: Card=ParallaxScrollView.card[0]
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Spacer()
                }
                .onAppear {
                    withAnimation(.smooth.delay(0.3)) {
                        self.showText=true
                    }
                }
                .onChange(of: self.show) {
                    self.showText=false
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .background {
                    Image(self.card.name)
                        .resizable()
                        .scaledToFill()
                        .matchedGeometryEffect(id: "image\(self.card.id)", in: self.namespace)
                }
                .mask(RoundedRectangle(cornerRadius: 20, style: .continuous).matchedGeometryEffect(id: "mask\(self.card.id)", in: self.namespace))
                .overlay {
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        Text(self.card.text)
                            .bold()
                            .font(.title)
                            .matchedGeometryEffect(id: "title\(self.card.id)", in: self.namespace)
                        
                        Text("ABCDEFGHIJKLMNOPQRDTUVWXYZbcdefghijklmnopqrstuvwxyz").opacity(self.showText ? 1:0)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .offset(y: 150)
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}
