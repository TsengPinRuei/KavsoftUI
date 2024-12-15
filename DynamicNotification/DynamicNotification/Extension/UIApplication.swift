//
//  UIApplication.swift
//  DynamicNotification
//
//  Created by 曾品瑞 on 2023/10/27.
//

import SwiftUI

extension UIApplication {
    func dynamicNotification<Content: View>(
        dynamicIsland: Bool=false,
        timeout: CGFloat=5,
        swipeToDismiss: Bool=true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        if let window=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag==0320 }) {
            let frame=window.frame
            let safeArea=window.safeAreaInsets
            var tag: Int=1009
            let checkDynamicIsland=dynamicIsland && safeArea.top>=51
            
            if let previousTag=UserDefaults.standard.value(forKey: "dynamic_notification_tag") as? Int {
                tag=previousTag+1
            }
            UserDefaults.standard.setValue(tag, forKey: "dynamic_notification_tag")
            
            if(checkDynamicIsland) {
                if let controller=window.rootViewController as? StatusBarController {
                    controller.statusBarStyle = .darkContent
                    controller.setNeedsStatusBarAppearanceUpdate()
                }
            }
            
            let configuration=UIHostingConfiguration {
                NotificationView(
                    content: content(),
                    safeArea: safeArea,
                    tag: tag,
                    dynamicIsland: checkDynamicIsland,
                    timeout: timeout,
                    swipeToDismiss: swipeToDismiss
                )
                .frame(width: frame.width-(checkDynamicIsland ? 20:30), height: 120, alignment: .top)
                .contentShape(.rect)
            }
            let view=configuration.makeContentView()
            view.tag=tag
            view.backgroundColor=UIColor.clear
            view.translatesAutoresizingMaskIntoConstraints=false
            
            if let rootView=window.rootViewController?.view {
                rootView.addSubview(view)
                view.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive=true
                view.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: (-(frame.height-safeArea.top)/2)+(checkDynamicIsland ? 11:safeArea.top)).isActive=true
            }
        }
    }
}
