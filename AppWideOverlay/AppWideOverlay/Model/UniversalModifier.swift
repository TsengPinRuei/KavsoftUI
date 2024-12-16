//
//  UniversalModifier.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

struct UniversalModifier<ViewContent: View>: ViewModifier {
    var animation: Animation
    
    @Binding var show: Bool
    
    @Environment(Universal.self) private var universal
    
    @ViewBuilder var content: ViewContent
    
    @State private var viewID: String?
    
    private func add() {
        if(self.universal.window != nil && self.viewID==nil) {
            self.viewID=UUID().uuidString
            guard let viewID=self.viewID else { return }
            
            withAnimation(self.animation) {
                self.universal.view.append(Universal.Overlay(id: viewID, view: AnyView(self.content)))
            }
        }
    }
    private func remove() {
        if let viewID=self.viewID {
            withAnimation(self.animation) {
                self.universal.view.removeAll(where: { $0.id==viewID })
            }
            self.viewID=nil
        }
    }
    
    func body(content: Content) -> some View {
        content.onChange(of: self.show, initial: true) {(_, new) in
            if(new) {
                self.add()
            } else {
                self.remove()
            }
        }
    }
}
