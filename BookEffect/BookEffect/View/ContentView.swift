//
//  ContentView.swift
//  BookEffect
//
//  Created by 曾品瑞 on 2024/5/1.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat=0
    
    @ViewBuilder
    private func FrontView(_ size: CGSize) -> some View {
        Color.white
            .overlay {
                Image(.CCU)
                    .resizable()
                    .scaledToFit()
            }
    }
    @ViewBuilder
    private func LeftView() -> some View {
        VStack(spacing: 5) {
            Image(.scenery)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .clipShape(.circle)
                .shadow(color: Color(.systemGray2), radius: 5, x: 5, y: 5)
            
            Text("National Chung Cheng University")
                .bold()
                .fontWidth(.condensed)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
    @ViewBuilder
    private func RightView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Description").font(.title3)
            
            Text("Welcome to CCU!")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                BookView(configuration: .init(progress: self.progress)) {size in
                    self.FrontView(size)
                } inLeft: {size in
                    self.LeftView()
                } inRight: {size in
                    self.RightView()
                }
                
                HStack {
                    Slider(value: self.$progress)
                    
                    Button("Flip") {
                        withAnimation(.smooth(duration: 1)) {
                            self.progress=(self.progress==1 ? 0.2:1)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(10)
                .background(.background, in: .rect(cornerRadius: 10))
                .padding(.top, 50)
            }
            .navigationTitle("BookView")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray4))
        }
    }
}

#Preview {
    ContentView()
}
