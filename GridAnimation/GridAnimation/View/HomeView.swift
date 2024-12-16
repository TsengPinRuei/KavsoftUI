//
//  HomeView.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct HomeView: View {
    @State private var slow: Bool=false
    @State private var nature: [Nature]=GridAnimation.nature
    
    var coordinator: UICoordinator=UICoordinator()
    
    @ViewBuilder
    private func NatureView(_ nature: Nature) -> some View {
        GeometryReader {
            let frame: CGRect=$0.frame(in: .global)
            
            CurrentView(nature: nature)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    self.coordinator.toggle(show: true, slow: self.slow, frame: frame, nature: nature)
                }
        }
        .frame(height: 200)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Photos")
                        .bold()
                        .font(.largeTitle)
                        .padding(.vertical, 10)
                    
                    Spacer(minLength: 0)
                    
                    Button("\(self.slow ? "Slow":"Normal") Animation") {
                        withAnimation(.smooth) {
                            self.slow.toggle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .contentTransition(.numericText())
                }
                
                LazyVGrid(
                    columns: Array(repeating: GridItem(spacing: 10), count: 2),
                    spacing: 10
                ) {
                    ForEach(self.nature) {nature in
                        self.NatureView(nature)
                    }
                }
            }
            .padding()
            .background {
                Extractor {
                    self.coordinator.scrollView=$0
                }
            }
        }
        .opacity(self.coordinator.root ? 0:1)
        .scrollDisabled(self.coordinator.root)
        .allowsHitTesting(!self.coordinator.root)
        .overlay {
            DetailView(slow: self.$slow)
                .environment(self.coordinator)
                .allowsHitTesting(self.coordinator.hide)
        }
    }
}
