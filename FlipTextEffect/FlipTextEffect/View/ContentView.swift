//
//  ContentView.swift
//  FlipTextEffect
//
//  Created by 曾品瑞 on 2024/6/2.
//

import SwiftUI

struct ContentView: View {
    @State private var duration: CGFloat=0.5
    @State private var font: CGFloat=80
    @State private var radius: CGFloat=10
    @State private var time: CGFloat=0
    @State private var count: Int=0
    @State private var background: Int=6
    @State private var foreground: Int=7
    
    private let color: [String]=["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Black", "White"]
    
    private func setColor(_ number: Int) -> Color {
        switch(number) {
        case 0: return .red
        case 1: return .orange
        case 2: return .yellow
        case 3: return .green
        case 4: return .blue
        case 5: return .purple
        case 6: return .black
        case 7: return .white
        default: return .clear
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    FlipEffect(
                        value: .constant(self.count/10),
                        size: CGSize(width: 100, height: 150),
                        font: self.font,
                        radius: self.radius,
                        foreground: self.setColor(self.foreground),
                        background: self.setColor(self.background),
                        duration: self.duration
                    )
                    
                    FlipEffect(
                        value: .constant(self.count%10),
                        size: CGSize(width: 100, height: 150),
                        font: self.font,
                        radius: self.radius,
                        foreground: self.setColor(self.foreground),
                        background: self.setColor(self.background),
                        duration: self.duration
                    )
                }
                .onReceive(Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()) {_ in
                    self.time+=0.01
                    if(self.time>=60) {
                        self.time=0
                    }
                    self.count=Int(self.time)
                }
                
                List {
                    Section("Font Size (50 ~ 100)") {
                        HStack(spacing: 0) {
                            Text("\(Int(self.font))")
                                .animation(.smooth, value: self.font)
                                .contentTransition(.numericText(value: self.font))
                            
                            Stepper("", value: self.$font, in: 50...100, step: 10)
                        }
                        
                    }
                    .headerProminence(.increased)
                    
                    Section("Corner Radius (10 ~ 50)") {
                        HStack(spacing: 0) {
                            Text("\(Int(self.radius))")
                                .animation(.smooth, value: self.radius)
                                .contentTransition(.numericText(value: self.radius))
                            
                            Stepper("", value: self.$radius, in: 10...50, step: 5)
                        }
                    }
                    .headerProminence(.increased)
                    
                    Section("Foreground") {
                        Picker("Color", selection: self.$foreground) {
                            ForEach(self.color.indices, id: \.self) {index in
                                if(self.background != index) {
                                    Text(self.color[index]).tag(index)
                                }
                            }
                        }
                        .tint(Color.primary)
                        .pickerStyle(.menu)
                    }
                    .headerProminence(.increased)
                    
                    Section("Background Color") {
                        Picker("Color", selection: self.$background) {
                            ForEach(self.color.indices, id: \.self) {index in
                                if(self.foreground != index) {
                                    Text(self.color[index]).tag(index)
                                }
                            }
                        }
                        .tint(Color.primary)
                        .pickerStyle(.menu)
                    }
                    .headerProminence(.increased)
                    
                    Section("Animation Duration") {
                        HStack(spacing: 0) {
                            Text("\(self.duration, specifier: "%.1f")")
                                .animation(.smooth, value: self.duration)
                                .contentTransition(.numericText(value: self.duration))
                            
                            Stepper("", value: self.$duration, in: 0.1...0.9, step: 0.1)
                        }
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
            }
            .navigationTitle("Clock")
            .animation(.smooth, value: self.font)
            .animation(.smooth, value: self.radius)
            .animation(.smooth, value: self.foreground)
            .animation(.smooth, value: self.background)
        }
    }
}

#Preview {
    ContentView()
}
