//
//  ContentView.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    
    var model: NatureModel=NatureModel()
    
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Button("", systemImage: "person.fill") { }
            
            Spacer(minLength: 0)
            
            Button("", systemImage: "magnifyingglass") { }
        }
        .overlay(Text("Nature"))
        .bold()
        .font(.title)
        .foregroundStyle(Color.primary)
        .padding()
        .background(.ultraThinMaterial)
    }
    
    var body: some View {
        @Bindable var binding: NatureModel=self.model
        
        GeometryReader {
            let size: CGSize=$0.size
            
            NavigationStack {
                VStack(spacing: 0) {
                    self.HeaderView()
                    
                    ScrollView(.vertical) {
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10) {
                            ForEach($binding.nature) {$nature in
                                NavigationLink(value: nature) {
                                    NatureView(nature: $nature, size: size)
                                        .environment(self.model)
                                        .frame(height: size.height*0.4)
                                        .matchedTransitionSource(id: nature.id, in: self.animation) {
                                            $0
                                                .background(.clear)
                                                .clipShape(.rect(cornerRadius: 20))
                                        }
                                }
                                .buttonStyle(LinkButton())
                            }
                        }
                        .padding()
                    }
                }
                .navigationDestination(for: Nature.self) {nature in
                    DetailView(animation: self.animation, nature: nature)
                        .environment(self.model)
                        .toolbarVisibility(.hidden, for: .navigationBar)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
