//
//  ContentView.swift
//  TextRenderer
//
//  Created by 曾品瑞 on 2024/9/20.
//

import SwiftUI

struct ContentView: View {
    @State private var show: Bool=false
    @State private var progress: CGFloat=0
    @State private var type: KeyRenderer.RendererType=KeyRenderer.RendererType.blur
    
    var body: some View {
        VStack {
            let api=Text("6C1C3U5C5C6U0C0C5U")
                .fontWeight(.semibold)
                .foregroundStyle(Color.primary)
                .customAttribute(KeyAttribute())
            
            Picker("", selection: self.$type) {
                ForEach(KeyRenderer.RendererType.allCases, id: \.rawValue) {type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            Text("Your API Key is \(api).")
                .font(.title)
                .fontDesign(.rounded)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .textRenderer(KeyRenderer(progress: self.progress, type: self.type))
                .padding(.vertical, 50)
            
            Button("\(self.show ? "Hide":"Show") Key") {
                withAnimation(.smooth) {
                    self.show.toggle()
                    self.progress=self.show ? 1:0
                }
            }
            .buttonStyle(.bordered)
            .bold()
            .font(.title3)
            .tint(Color.primary)
            .contentTransition(.numericText())
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
