//
//  Hero.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct Hero<Content: View>: View {
    @Environment(\.scenePhase) private var scene
    
    @State private var window: PassWindow?
    
    @StateObject private var hero: HeroModel=HeroModel()
    
    @ViewBuilder var content: Content
    
    private func addWindow() {
        for i  in UIApplication.shared.connectedScenes {
            if let scene=i as? UIWindowScene,
               i.activationState == .foregroundActive,
               self.window==nil {
                let window: PassWindow=PassWindow(windowScene: scene)
                window.backgroundColor=UIColor.clear
                window.isUserInteractionEnabled=false
                window.isHidden=false
                
                let root: UIHostingController=UIHostingController(rootView: HeroLayerView().environmentObject(self.hero))
                root.view.frame=scene.screen.bounds
                root.view.backgroundColor=UIColor.clear
                
                window.rootViewController=root
                
                self.window=window
            }
        }
        
        if(self.window==nil) {
            print("Hero: No window scene found")
        }
    }
    
    var body: some View {
        self.content
            .onChange(value: self.scene) { value in
                if(value == .active) { self.addWindow() }
            }
            .environmentObject(self.hero)
    }
}
