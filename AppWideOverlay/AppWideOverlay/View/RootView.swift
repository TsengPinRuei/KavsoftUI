//
//  RootView.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

struct RootView<Content: View>: View {
    var content: Content
    var universal: Universal=Universal()
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content=content()
    }
    
    var body: some View {
        self.content
            .environment(self.universal)
            .onAppear {
                if let scene=(UIApplication.shared.connectedScenes.first as? UIWindowScene), self.universal.window==nil {
                    let window=PassWindow(windowScene: scene)
                    window.isHidden=false
                    window.isUserInteractionEnabled=true
                    
                    let root: UIHostingController=UIHostingController(rootView: UniversalView().environment(self.universal))
                    root.view.backgroundColor=UIColor.clear
                    window.rootViewController=root
                    
                    self.universal.window=window
                }
            }
    }
}
