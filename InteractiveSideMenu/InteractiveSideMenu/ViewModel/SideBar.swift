//
//  SideBar.swift
//  InteractiveSideMenu
//
//  Created by 曾品瑞 on 2024/3/26.
//

import SwiftUI

struct SideBar<Content: View, MenuView: View, Background: View>: View {
    var expand: Bool=true
    var interact: Bool=true
    var width: CGFloat=200
    var corner: CGFloat=20
    
    @Binding var show: Bool
    
    @ViewBuilder var content: (UIEdgeInsets) -> Content
    @ViewBuilder var menu: (UIEdgeInsets) -> MenuView
    @ViewBuilder var background: Background
    
    @GestureState private var drag: Bool=false
    
    @State private var currentX: CGFloat=0
    @State private var endX: CGFloat=0
    @State private var progress: CGFloat=0
    
    private var gesture: some Gesture {
        DragGesture()
            .updating(self.$drag) {(_, out, _) in
                out=true
            }
            .onChanged {value in
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    guard value.startLocation.x>10 else { return }
                    
                    let x: CGFloat=self.drag ? max(min(value.translation.width+self.endX, self.width), 0):0
                    self.currentX=x
                    self.getProgress()
                }
            }
            .onEnded {value in
                guard value.startLocation.x>10 else { return }
                
                withAnimation(.snappy) {
                    let velocity: CGFloat=value.velocity.width/8
                    let total: CGFloat=velocity+self.currentX
                    
                    if(total>self.width*0.5) {
                        self.showMenu()
                    } else {
                        self.reset()
                    }
                }
            }
    }
    
    private func getProgress() {
        self.progress=max(min(self.currentX/self.width, 1), 0)
    }
    private func reset() {
        self.currentX=0
        self.endX=0
        self.show=false
        self.getProgress()
    }
    private func showMenu() {
        self.currentX=self.width
        self.endX=self.currentX
        self.show=true
        self.getProgress()
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            let safeArea: UIEdgeInsets=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets ?? .zero
            
            HStack(spacing: 0) {
                GeometryReader {_ in
                    self.menu(safeArea)
                }
                .frame(width: self.width)
                .contentShape(.rect)
                
                GeometryReader {_ in
                    self.content(safeArea)
                }
                .frame(width: size.width)
                .overlay {
                    if(self.interact && self.progress>0) {
                        Rectangle()
                            .fill(.black.opacity(self.progress*0.2))
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    self.reset()
                                }
                            }
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius: self.progress*self.corner)
                }
                .scaleEffect(self.expand ? 1-self.progress*0.1:1, anchor: .trailing)
                .rotation3DEffect(Angle(degrees: self.expand ? self.progress * -15:0), axis: (x: 0, y: 1, z: 0))
            }
            .frame(width: size.width+self.width, height: size.height)
            .offset(x: -self.width)
            .offset(x: self.currentX)
            .contentShape(.rect)
            .simultaneousGesture(self.gesture)
        }
        .background(InteractiveSideMenu.menuColor)
        .ignoresSafeArea()
        .onChange(of: self.show, initial: true) {(old, new) in
            withAnimation(.snappy) {
                if(new) {
                    self.showMenu()
                } else {
                    self.reset()
                }
            }
        }
    }
}
