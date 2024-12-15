//
//  TabBarButton.swift
//  InstagramProfile
//
//  Created by 曾品瑞 on 2023/12/12.
//

import SwiftUI

struct TabBarButton: View {
    var isSystem: Bool
    var image: String
    var animation: Namespace.ID
    
    @Binding var tab: String
    
    var body: some View {
        VStack(spacing: 10) {
            (self.isSystem ? Image(systemName: self.image):Image(self.image))
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(self.tab==self.image ? Color.primary:Color.gray)
            
            ZStack {
                if(self.tab==self.image) {
                    Rectangle()
                        .fill(Color.primary)
                        .matchedGeometryEffect(id: "TAB", in: self.animation)
                } else {
                    Rectangle().fill(.clear)
                }
            }
            .frame(height: 2)
        }
        .onTapGesture {
            withAnimation(.smooth) {
                self.tab=self.image
            }
        }
    }
}
