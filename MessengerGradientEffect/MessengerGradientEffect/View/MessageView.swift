//
//  MessageView.swift
//  MessengerGradientEffect
//
//  Created by 曾品瑞 on 2024/10/4.
//

import SwiftUI

struct MessageView: View {
    var screen: GeometryProxy
    var message: Message
    
    var body: some View {
        Text(self.message.message)
            .padding(10)
            .foregroundStyle(self.message.reply ? Color.primary:Color.white)
            .background {
                if(self.message.reply) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.25))
                } else {
                    GeometryReader {
                        let rect: CGRect=$0.frame(in: .global)
                        let size: CGSize=$0.size
                        let screen: CGSize=self.screen.size
                        let safeArea: EdgeInsets=self.screen.safeAreaInsets
                        
                        Rectangle()
                            .fill(
                                .linearGradient(
                                    colors: [Color(.color1), Color(.color2), Color(.color3), Color(.color4)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .mask(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: size.width, height: size.height)
                                    .offset(x: rect.minX, y: rect.minY)
                            }
                            .offset(x: -rect.minX, y: -rect.minY)
                            .frame(width: screen.width, height: screen.height+safeArea.top+safeArea.bottom)
                    }
                }
            }
            .frame(maxWidth: 300, alignment: self.message.reply ? .leading:.trailing)
            .frame(maxWidth: .infinity, alignment: self.message.reply ? .leading:.trailing)
    }
}
