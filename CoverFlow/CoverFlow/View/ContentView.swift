//
//  ContentView.swift
//  CoverFlow
//
//  Created by 曾品瑞 on 2024/1/17.
//

import SwiftUI

struct ContentView: View {
    @State private var reflection: Bool=false
    @State private var spacing: CGFloat=0
    @State private var rotation: CGFloat=CGFloat.zero
    @State private var item: [CoverFlowItem]=[.red, .orange, .yellow, .green, .blue, .purple].compactMap {
        return CoverFlowItem(color: $0)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 0)
                
                CoverFlowView(
                    width: 250,
                    spacing: self.spacing,
                    reflection: self.reflection,
                    rotation: self.rotation,
                    item: self.item
                ) {item in
                    RoundedRectangle(cornerRadius: 20).fill(item.color.gradient)
                }
                .frame(height: 200)
                
                Spacer(minLength: 0)
                
                VStack(alignment: .leading, spacing: 10) {
                    Toggle("Reflection", isOn: self.$reflection)
                    
                    Text("Spacing: \(Int(self.spacing))").foregroundStyle(.gray)
                    
                    Slider(value: self.$spacing, in: -20...20)
                    
                    Text("Rotation: \(Int(self.rotation))").foregroundStyle(.gray)
                    
                    Slider(value: self.$rotation, in: 0...90)
                }
                .padding()
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                .padding()
            }
            .navigationTitle("CoverFlow")
        }
        .preferredColorScheme(.dark)
    }
}
