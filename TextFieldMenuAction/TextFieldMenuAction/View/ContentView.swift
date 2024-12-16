//
//  ContentView.swift
//  TextFieldMenuAction
//
//  Created by 曾品瑞 on 2024/11/14.
//

import SwiftUI

struct ContentView: View {
    @State private var show: Bool=true
    @State private var replace: String=""
    @State private var text: String=""
    @State private var selection: TextSelection?
    
    var body: some View {
        NavigationStack {
            List {
                Section("TextField") {
                    TextField("Type something...", text: self.$text, selection: self.$selection)
                        .menu(show: self.show) {
                            TextAction(title: "Uppercase") { (_, field) in
                                if let range: UITextRange=field.selectedTextRange,
                                   let text: String=field.text(in: range) {
                                    let up: String=text.uppercased()
                                    field.replace(range, withText: up)
                                    field.selectedTextRange=range
                                }
                            }
                            
                            TextAction(title: "Lowercase") { (_, field) in
                                if let range: UITextRange=field.selectedTextRange,
                                   let text: String=field.text(in: range) {
                                    let low: String=text.lowercased()
                                    field.replace(range, withText: low)
                                    field.selectedTextRange=range
                                }
                            }
                            
                            TextAction(title: "Replace") { (_, field) in
                                if let range: UITextRange=field.selectedTextRange {
                                    field.replace(range, withText: self.replace)
                                    if let start=field.position(from: range.start, offset: 0),
                                       let end=field.position(from: range.start, offset: self.replace.count) {
                                        field.selectedTextRange=field.textRange(from: start, to: end)
                                    }
                                }
                            }
                        }
                    
                    Text(self.text)
                }
                .headerProminence(.increased)
                .listRowSeparatorTint(.primary)
                
                Section("Replace Text") {
                    TextField("Replacement", text: self.$replace)
                        .menu(show: false) { }
                }
                .headerProminence(.increased)
                
                Section("Suggestion") {
                    Toggle("Show Suggestion", isOn: self.$show)
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Text Menu")
        }
    }
}

#Preview {
    ContentView()
}
