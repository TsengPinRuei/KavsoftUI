//
//  ContentView.swift
//  LimitTextField
//
//  Created by 曾品瑞 on 2024/4/3.
//

import SwiftUI

struct ContentView: View {
    @State private var excess: Bool=false
    @State private var resize: Bool=false
    @State private var border: CGFloat=1
    @State private var radius: CGFloat=0
    @State private var type: Int=2
    @State private var text: String=""
    
    var body: some View {
        NavigationStack {
            VStack {
                LimitTextFieldView(
                    configuration:
                        LimitTextFieldView.Configuration(
                            limit: 40,
                            resize: self.resize,
                            excess: self.excess,
                            border: LimitTextFieldView.Border(radius: self.radius, width: self.border),
                            progress: LimitTextFieldView.Progress(ring: self.type%2==0, text: self.type>=1)
                        ),
                    hint: "Tell Me Something",
                    text: self.$text
                )
                .autocorrectionDisabled()
                .frame(maxHeight: 200)
                .contentTransition(.numericText(value: Double(self.text.count)))
                .animation(.easeInOut, value: self.text)
                .animation(.easeInOut, value: self.excess)
                .animation(.easeInOut, value: self.resize)
                .animation(.easeInOut, value: self.border)
                .animation(.easeInOut, value: self.radius)
                
                List {
                    Section("Indicator Type") {
                        Picker("", selection: self.$type) {
                            Text("Ring").tag(0)
                            
                            Text("Text").tag(1)
                            
                            Text("Both").tag(2)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Toggle("Excess Typing", isOn: self.$excess)
                    
                    Toggle("Resize TextField", isOn: self.$resize)
                    
                    Section("Border Width ( 0 ~ 10 )") {
                        HStack {
                            Text("\(Int(self.border))")
                                .animation(.snappy, value: self.border)
                                .contentTransition(.numericText(value: self.border))
                            
                            Stepper("", value: self.$border, in: 0...10, step: 1)
                        }
                    }
                    
                    Section("Border Radius ( 1 ~ 50 )") {
                        HStack {
                            Text("\(Int(self.radius))")
                                .animation(.snappy, value: self.radius)
                                .contentTransition(.numericText(value: self.radius))
                            
                            Stepper("", value: self.$radius, in: 0...30, step: 5)
                        }
                    }
                }
                .clipShape(.rect(cornerRadius: 10))
            }
            .navigationTitle("Limit TextField")
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
