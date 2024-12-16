//
//  ContentView.swift
//  ExpandableSlider
//
//  Created by 曾品瑞 on 2024/11/17.
//

import SwiftUI

struct ContentView: View {
    @State private var animation: Bool=true
    @State private var bell: CGFloat=20
    @State private var speaker: CGFloat=20
    
    var body: some View {
        NavigationStack {
            List {
                Section("Speaker") {
                    ExpandSlider(value: self.$speaker, in: 0...100) {
                        HStack {
                            Image(systemName: "speaker.wave.3.fill", variableValue: self.speaker/100).bold()
                            
                            Spacer(minLength: 0)
                            
                            Text("\(Int(self.speaker))%")
                                .bold()
                                .font(.callout)
                                .contentTransition(.numericText(value: self.speaker))
                                .animation(self.animation ? .snappy:.none, value: self.speaker)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .headerProminence(.increased)
                
                Section("Bell") {
                    ExpandSlider(value: self.$bell, in: 0...100) {
                        HStack {
                            Image(systemName: "bell.and.waves.left.and.right", variableValue: self.bell/100).bold()
                            
                            Spacer(minLength: 0)
                            
                            Text("\(Int(self.bell))%")
                                .bold()
                                .font(.callout)
                                .contentTransition(.numericText(value: self.bell))
                                .animation(self.animation ? .snappy:.none, value: self.bell)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .headerProminence(.increased)
                
                Toggle("Text Animation", isOn: self.$animation)
            }
            .navigationTitle("Slider Setting")
        }
    }
}
