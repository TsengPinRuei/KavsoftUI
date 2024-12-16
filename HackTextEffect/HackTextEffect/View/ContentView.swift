//
//  ContentView.swift
//  HackTextEffect
//
//  Created by 曾品瑞 on 2024/5/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var scheme
    
    @State private var mode: Bool=false
    @State private var trigger: Bool=false
    @State private var duration: CGFloat=1
    @State private var speed: CGFloat=0.05
    @State private var transition: Int=0
    @State private var text: String="Chaoyang\nUniversity\nof\nTechnology"
    
    private let name: [String]=[
        "National\nTaiwan\nUniversity",
        "National\nTsing Hua\nUniversity",
        "National\nYang Ming Chiao Tung\nUniversity",
        "National\nCheng Kung\nUniversity",
        "National\nCentral\nUniversity",
        "National\nSun Yat-sen\nUniversity",
        "National\nChung Hsing\nUniversity",
        "National\nChung Cheng\nUniversity"
    ]
    
    private func setTransition() -> ContentTransition {
        switch(self.transition) {
        case 0: return .identity
        case 1: return .interpolate
        case 2: return .opacity
        case 3: return .numericText()
        default: return .identity
        }
    }
    
    var body: some View {
        VStack {
            HackTextView(
                text: self.text,
                trigger: self.trigger,
                transition: self.setTransition(),
                duration: self.duration,
                speed: self.speed
            )
            .bold()
            .font(.largeTitle)
            .foregroundStyle(self.scheme == .dark ? .green:.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black.opacity(self.scheme == .dark ? 1:0.2), in: .rect(cornerRadius: 20))
            .overlay(alignment: .topLeading) {
                Button("", systemImage: self.scheme == .dark ? "moon.fill":"sun.max.fill") {
                    withAnimation(.smooth) {
                        self.mode.toggle()
                    }
                }
                .tint(self.scheme == .dark ? .yellow:.red)
                .font(.title)
                .symbolEffect(.bounce, value: self.mode)
                .padding([.leading, .top])
            }
            
            VStack(spacing: 30) {
                Picker("", selection: self.$transition) {
                    Text("IDENTITY").tag(0)
                    
                    Text("INTERPOLATE").tag(1)
                    
                    Text("OPACITY").tag(2)
                    
                    Text("NUMERIC TEXT").tag(3)
                }
                .pickerStyle(.wheel)
                .background(.background.opacity(0.8), in: .rect(cornerRadius: 20))
                
                VStack {
                    HStack{
                        Text("DURATION").bold()
                        
                        Stepper(
                            "\(self.duration, specifier: "%.1f")",
                            value: self.$duration,
                            in: 0.5...2,
                            step: 0.1
                        )
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.background.opacity(0.8), in: .rect(cornerRadius: 10))
                        .contentTransition(.numericText(value: self.duration))
                        .animation(.smooth, value: self.duration)
                    }
                    
                    HStack{
                        Text("SPEED").bold()
                        
                        Stepper(
                            "\(self.speed, specifier: "%.2f")",
                            value: self.$speed,
                            in: 0.01...0.1,
                            step: 0.01
                        )
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.background.opacity(0.8), in: .rect(cornerRadius: 10))
                        .contentTransition(.numericText(value: self.speed))
                        .animation(.smooth, value: self.speed)
                    }
                }
                
                Button("UPDATE") {
                    self.text=self.name[Int.random(in: 0..<self.name.count)]
                    self.trigger.toggle()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .background(.background.opacity(0.8), in: .rect(cornerRadius: 10))
            }
            .font(.title3)
            .padding()
            .background(Color(.systemGray4), in: .rect(cornerRadius: 20))
        }
        .padding(.horizontal)
        .preferredColorScheme(self.mode ? .dark:.light)
    }
}

#Preview {
    ContentView()
}
