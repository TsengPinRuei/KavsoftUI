//
//  StatusBarController.swift
//  DynamicNotification
//
//  Created by 曾品瑞 on 2023/10/27.
//

import SwiftUI

class StatusBarController: UIViewController {
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
}
