//
//  DoubleTapView.swift
//  YouTubeVideoPlayer
//
//  Created by 曾品瑞 on 2024/4/19.
//

import SwiftUI

struct DoubleTapView: View {
    @State private var isTap: Bool=false
    @State private var show: [Bool]=[false, false, false]
    
    var forward: Bool=false
    var tap: () -> ()
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .overlay {
                Circle()
                    .fill(.white.opacity(0.2))
                    .scaleEffect(2, anchor: self.forward ? .leading:.trailing)
            }
            .clipped()
            .opacity(self.isTap ? 1:0)
            .overlay {
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        ForEach(0...2, id: \.self) {index in
                            Image(systemName: "arrowtriangle.backward.fill").opacity(self.show[index] ? 1:0.0)
                        }
                    }
                    .font(.title3)
                    .rotationEffect(Angle(degrees: self.forward ? 180:0))
                    
                    Text("10 Seconds")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .opacity(self.isTap ? 1:0)
            }
            .contentShape(.rect)
            .onTapGesture(count: 2) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.isTap=true
                    self.show[2]=true
                }
                withAnimation(.easeIn(duration: 0.2).delay(0.2)) {
                    self.show[2]=false
                    self.show[1]=true
                }
                withAnimation(.easeIn(duration: 0.2).delay(0.4)) {
                    self.show[1]=false
                    self.show[0]=true
                }
                withAnimation(.easeIn(duration: 0.2).delay(0.6)) {
                    self.show[0]=false
                    self.isTap=false
                }
                
                self.tap()
            }
    }
}
