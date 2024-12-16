//
//  HomeView.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/12.
//

import SwiftUI

struct HomeView: View {
    @Binding var slow: Bool
    
    @Environment(UICoordinator.self) private var coordinator
    
    @ViewBuilder
    private func ImageView(_ nature: Nature) -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            Rectangle()
                .fill(.clear)
                .anchorPreference(key: HeroKey.self, value: .bounds) {anchor in
                    return [nature.id+"START":anchor]
                }
            
            if let preview=nature.preview {
                Image(uiImage: preview)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .opacity(self.coordinator.current?.id==nature.id ? 0:1)
            }
        }
        .frame(height: 150)
        .contentShape(.rect)
    }
    
    var body: some View {
        @Bindable var bCoordinator: UICoordinator=self.coordinator
        
        ScrollViewReader {reader in
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(spacing: 2.5), count: 3),
                        spacing: 2.5
                    ) {
                        ForEach($bCoordinator.nature) {$nature in
                            self.ImageView(nature)
                                .id(nature.id)
                                .frameChange {(frame, bounds) in
                                    let height: CGFloat=bounds.height
                                    let maxY: CGFloat=frame.maxY
                                    let minY: CGFloat=frame.minY
                                    
                                    if(maxY<0 || minY>height) {
                                        nature.appear=false
                                    } else {
                                        nature.appear=true
                                    }
                                }
                                .onDisappear {
                                    self.coordinator.current=nature
                                }
                                .onTapGesture {
                                    self.coordinator.current=nature
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .onChange(of: self.coordinator.current) {(_, new) in
                if let nature=self.coordinator.nature.first(where: { $0.id==new?.id }), !nature.appear {
                    reader.scrollTo(nature.id, anchor: .bottom)
                }
            }
        }
        .navigationTitle("Recent")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(self.slow ? "Normal Motion":"Slow Motion") {
                    self.slow.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
