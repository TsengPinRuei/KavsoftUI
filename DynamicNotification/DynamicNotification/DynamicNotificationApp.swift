//
//  DynamicNotificationApp.swift
//  DynamicNotification
//
//  Created by 曾品瑞 on 2023/10/27.
//

import SwiftUI

@main
struct DynamicNotificationApp: App {
    @State private var window: PassWindow?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if(self.window==nil) {
                        if let windowScene=UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            let window=PassWindow(windowScene: windowScene)
                            let controller=StatusBarController()
                            
                            window.backgroundColor=UIColor.clear
                            window.tag=0320
                            controller.view.backgroundColor=UIColor.clear
                            window.rootViewController=controller
                            window.isHidden=false
                            window.isUserInteractionEnabled=true
                            
                            self.window=window
                        }
                    }
                }
        }
    }
}
