//
//  ContentView.swift
//  ScreenshotPreventation
//
//  Created by 曾品瑞 on 2024/1/7.
//

import SwiftUI

struct ContentView: View {
    @State private var prevent: Bool=false
    @State private var preventRadius: Double=0
    @State private var radius: Double=0
    
    @ViewBuilder
    private func SliderView(title: String, value: Binding<Double>) -> some View {
        VStack(spacing: 5) {
            Text(title)
            
            Slider(value: value, in: 0...50)
            
            Capsule()
                .frame(height: 1)
                .padding(.top, 10)
                .padding(.bottom)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color(.systemGray3).gradient)
                    .ignoresSafeArea()
                
                VStack {
                    self.SliderView(title: "RoundedRectangle Corner Radius", value: self.$radius)
                    
                    self.SliderView(title: "Prevent View Corner Radius", value: self.$preventRadius)
                }
                .padding()
                
                Toggle("Prevent Screenshot", isOn: self.$prevent)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding()
                
                RoundedRectangle(cornerRadius: self.radius)
                    .preventScreenshot(protect: self.prevent)
                    .clipShape(.rect(cornerRadius: self.preventRadius))
                    .frame(width: 200, height: 200)
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .font(.headline)
            .navigationTitle("Screenshot Preventation")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
    }
}
