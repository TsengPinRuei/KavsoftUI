//
//  HomeView.swift
//  AnimatedPagingIndicator
//
//  Created by 曾品瑞 on 2024/1/2.
//

import SwiftUI

struct HomeView: View {
    @State private var clip: Bool=false
    @State private var opacity: Bool=false
    @State private var count: Int=0
    @State private var color: [Color]=[.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(self.color, id: \.self) {color in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color.gradient)
                            .padding(.horizontal, 5 )
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
                .overlay(alignment: .bottom) {
                    PagingIndicator(
                        tint: .white,
                        current: .black.opacity(0.2),
                        opacity: self.opacity,
                        clip: self.clip
                    )
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 250)
            .safeAreaPadding(.vertical)
            .safeAreaPadding(.horizontal, 30)
            
            List {
                Section("Options") {
                    Toggle("Opacity Effect", isOn: self.$opacity)
                    
                    Toggle("Clip Edge", isOn: self.$clip)
                    
                    Button("Add Color") {
                        withAnimation(.smooth) {
                            self.color.append(self.color[self.count%6])
                            self.count+=1
                        }
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            .padding()
        }
        .navigationTitle("Paging Indicator")
    }
}
