//
//  DetailView.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/12.
//

import SwiftUI

struct DetailView: View {
    @Binding var slow: Bool
    
    @Environment(UICoordinator.self) private var coordinator
    
    @ViewBuilder
    private func BottomBarView() -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(self.coordinator.nature) {nature in
                        if let preview=nature.preview {
                            Image(uiImage: preview)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 80)
                                .clipShape(.rect)
                                .padding(.horizontal, self.coordinator.current?.id==nature.id ? 10:0)
                                .animation(.easeInOut(duration: 0.1), value: self.coordinator.current)
                        }
                    }
                }
                .padding(.vertical, 10)
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, (size.width-40)/2)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: Binding(get: { return self.coordinator.indicatorPosition }, set: { self.coordinator.indicatorPosition=$0 }))
            .onChange(of: self.coordinator.indicatorPosition) {
                self.coordinator.indicatorChange()
            }
        }
        .frame(height: 100)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
    }
    @ViewBuilder
    private func ImageView(_ nature: Nature, size: CGSize) -> some View {
        if let image=nature.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height)
                .clipped()
                .contentShape(.rect)
        }
    }
    @ViewBuilder
    private func TopBarView() -> some View {
        HStack {
            Button("", systemImage: "chevron.left") {
                self.coordinator.toggle(show: false, slow: self.slow)
            }
            .bold()
            
            Spacer(minLength: 0)
            
            HStack(spacing: 20) {
                Button("Edit") {}
                
                Button("", systemImage: "ellipsis.circle") {}
            }
        }
        .font(.title2)
        .padding([.top, .horizontal])
        .padding(.bottom, 10)
        .background(.ultraThinMaterial)
        .opacity(self.coordinator.show ? 1.0-abs(self.coordinator.progress):0)
        .animation(.easeInOut(duration: 0.2), value: self.coordinator.show)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            self.TopBarView()
            
            GeometryReader {
                let size: CGSize=$0.size
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(self.coordinator.nature) {nature in
                            self.ImageView(nature, size: size)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: Binding(get: { return self.coordinator.scrollPosition }, set: { self.coordinator.scrollPosition=$0 }))
                .onChange(of: self.coordinator.scrollPosition) {
                    self.coordinator.scrollChange()
                }
                .background {
                    if let current=self.coordinator.current {
                        Rectangle()
                            .fill(.clear)
                            .anchorPreference(key: HeroKey.self, value: .bounds) {anchor in
                                return [current.id+"END":anchor]
                            }
                    }
                }
                .offset(self.coordinator.offset)
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: 10)
                    .contentShape(.rect)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged {value in
                                let translation: CGSize=value.translation
                                let height: CGFloat=max(min(translation.height/200, 1), -1)
                                
                                self.coordinator.offset=translation
                                self.coordinator.progress=height
                            }
                            .onEnded {value in
                                let translation: CGSize=value.translation
                                let velocity: CGSize=value.velocity
                                let height: CGFloat=translation.height+velocity.height/5
                                let width: CGFloat=translation.width+velocity.width/5
                                
                                if(abs(height)>=size.height*0.5 || width>=size.width*0.5) {
                                    self.coordinator.toggle(show: false, slow: self.slow)
                                } else {
                                    withAnimation(self.slow ? .easeInOut(duration: 2):.easeInOut.speed(2)) {
                                        self.coordinator.offset=CGSize.zero
                                        self.coordinator.progress=0
                                    }
                                }
                            }
                    )
            }
            .opacity(self.coordinator.show ? 1:0)
            
            self.BottomBarView()
                .opacity(self.coordinator.show ? 1.0-abs(self.coordinator.progress):0)
                .animation(.easeInOut(duration: 0.2), value: self.coordinator.show)
        }
        .onAppear {
            self.coordinator.toggle(show: true, slow: self.slow)
        }
    }
}

#Preview {
    ContentView()
}
