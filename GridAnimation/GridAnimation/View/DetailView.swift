//
//  DetailView.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct DetailView: View {
    @Binding var slow: Bool
    
    @Environment(UICoordinator.self) private var coordinator
    
    @ViewBuilder
    private func HeaderView(_ nature: Nature) -> some View {
        HStack {
            Spacer(minLength: 0)
            
            Button {
                self.coordinator.toggle(show: false, slow: self.slow, frame: .zero, nature: nature)
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.primary, .background)
                    .padding(10)
                    .shadow(color: Color.primary, radius: 3)
                    .contentShape(.rect)
            }
        }
        .animation(.easeIn(duration: 0.3)) {
            $0.opacity(self.coordinator.hide ? 1:0)
        }
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            let animate: Bool=self.coordinator.animate
            let hide: Bool=self.coordinator.hide
            let rect: CGRect=self.coordinator.rect
            
            let anchorX: CGFloat=self.coordinator.rect.minX/size.width>0.5 ? 1:0
            let scale: CGFloat=size.width/self.coordinator.rect.width
            let contextHeight: CGFloat=rect.height*scale
            let scrollHeight: CGFloat=size.height-contextHeight
            let offsetX: CGFloat=animate ? (anchorX>0.5 ? 16:-16)*scale:0
            let offsetY: CGFloat=animate ? -self.coordinator.rect.minY*scale:0
            
            if let image=self.coordinator.layer,
               let current=self.coordinator.current {
                if(!hide) {
                    Image(uiImage: image)
                        .scaleEffect(animate ? scale:1, anchor: UnitPoint(x: anchorX, y: 0))
                        .offset(x: offsetX, y: offsetY)
                        .offset(y: animate ? -self.coordinator.header:0)
                        .opacity(animate ? 0:1)
                        .transition(.identity)
                }
                
                ScrollView(.vertical) {
                    ContextView()
                        .safeAreaInset(edge: .top, spacing: 0) {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: contextHeight)
                                .offsetY {offset in
                                    self.coordinator.header=max(min(-offset, contextHeight), 0)
                                }
                        }
                }
                .scrollDisabled(!hide)
                .contentMargins(.top, contextHeight, for: .scrollIndicators)
                .background {
                    Rectangle()
                        .fill(.background)
                        .padding(.top, scrollHeight)
                }
                .animation(.easeInOut(duration: 0.3).speed(1.5)) {
                    $0
                        .offset(y: animate ? 0:scrollHeight)
                        .opacity(animate ? 1:0)
                }
                
                CurrentView(nature: current)
                    .allowsHitTesting(false)
                    .frame(width: animate ? size.width:rect.width, height: animate ? rect.height*scale:rect.height)
                    .clipShape(.rect(cornerRadius: animate ? 0:10))
                    .overlay(alignment: .top) {
                        self.HeaderView(current)
                            .offset(y: self.coordinator.header)
                            .padding(.top, self.safeArea.top)
                    }
                    .offset(x: animate ? 0:rect.minX, y: animate ? 0:rect.minY)
                    .offset(y: animate ? -self.coordinator.header:0)
            }
        }
        .ignoresSafeArea()
    }
}
