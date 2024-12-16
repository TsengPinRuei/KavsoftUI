//
//  ContentView.swift
//  GlitchTextEffect
//
//  Created by 曾品瑞 on 2024/6/7.
//

import SwiftUI

struct ContentView: View {
    @State private var glitch: Bool=false
    @State private var shadow: CGFloat=1
    
    @ViewBuilder
    private func GlitchTextView(_ text: String) -> some View {
        ZStack {
            GlitchView(
                glitch: self.glitch,
                text: text,
                shadow: .red
            ) {
                LinearKeyframe(
                    Glitch(top: 0, center: 5, bottom: 0, shadow: self.shadow),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: 5, center: -5, bottom: 5, shadow: self.shadow/3),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: -5, center: 0, bottom: -5, shadow: self.shadow/2),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: 0, center: 0, bottom: 5, shadow: self.shadow),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: 5, center: 0, bottom: 0, shadow: self.shadow),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: 0, center: -5, bottom: 0, shadow: self.shadow),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(),
                    duration: 0.1
                )
            }
            .font(.largeTitle)
            .fontWeight(.semibold)
            
            GlitchView(
                glitch: self.glitch,
                text: text,
                shadow: .green
            ) {
                LinearKeyframe(
                    Glitch(top: 5, center: 0, bottom: 5, shadow: self.shadow/2),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: 5, center: 5, bottom: 5, shadow: self.shadow/3),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: 5, center: -5, bottom: -5, shadow: self.shadow/3),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: -5, center: -5, bottom: 0, shadow: self.shadow/2),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(top: -5, center: 0, bottom: 5, shadow: self.shadow/2),
                    duration: 0.1
                )
                
                LinearKeyframe(
                    Glitch(),
                    duration: 0.1
                )
            }
            .font(.largeTitle)
            .fontWeight(.semibold)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                self.GlitchTextView("Justin")
                
                Divider()
                
                self.GlitchTextView("National Chung Cheng University")
                
                Divider()
                
                self.GlitchTextView("613556005")
                
                Divider()
                
                self.GlitchTextView("!@#$%^&*()_+")
            }
            .padding()
            .navigationTitle("Glitch Text")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Text("Glitch Shadow").bold()
                        
                        Stepper("\(self.shadow, specifier: "%.1f")", value: self.$shadow, in: 0.1...1, step: 0.1)
                            .animation(.smooth, value: self.shadow)
                            .contentTransition(.numericText(value: self.shadow))
                    }
                    .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("GLITCH") {
                        self.glitch.toggle()
                    }
                    .bold()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
