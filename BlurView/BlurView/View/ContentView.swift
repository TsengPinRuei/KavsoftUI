//
//  ContentView.swift
//  BlurView
//
//  Created by 曾品瑞 on 2024/1/10.
//

import SwiftUI

struct ContentView: View {
    @State private var show: Bool=false
    @State private var radius: CGFloat=3
    @State private var back: Int=7
    
    let backs: [Color]=[.red, .orange, .yellow, .green, .blue, .purple, .black, .white]
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                Stepper("Blur Radius : \(Int(self.radius))", value: self.$radius, in: 0...10)
                    .contentTransition(.numericText(value: self.radius))
                    .animation(.smooth, value: self.radius)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Blur Background")
                    
                    Spacer()
                    
                    Picker("", selection: self.$back) {
                        ForEach(self.backs.indices, id: \.self) {index in
                            Text("\(self.backs[index].description.uppercased())").tag(index)
                        }
                    }
                    .tint(.white)
                }
                .padding(.horizontal, 10)
            }
            .font(.title)
            
            Divider()
            
            Text("Justin\nJust\nIn")
                .bold()
                .font(.system(size: 50))
                .foregroundStyle(.orange)
            
            Divider()
            
            Button("BLUR MODE") {
                self.show.toggle()
            }
            .bold()
            .font(.title)
            .foregroundStyle(.white)
            .padding(.vertical, 5)
            .padding(.horizontal)
            .background(.ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 10))
        }
        .modifier(Blur(show: self.$show, radius: self.radius) {
            ZStack {
                self.backs[self.back]
                    .opacity(0.1)
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()
            .onTapGesture {
                self.show.toggle()
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
    }
}
