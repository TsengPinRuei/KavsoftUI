//
//  SecureViewController.swift
//  ScreenshotPreventation
//
//  Created by 曾品瑞 on 2024/1/7.
//

import Foundation
import SwiftUI
import UIKit

final class SecureViewController<Content: View>: UIViewController {
    private let content: () -> Content
    private let secureView: PreventView=PreventView()
    
    var prevent: Bool=true {
        didSet {
            self.secureView.prevent=self.prevent
        }
    }
    
    init(prevent: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.prevent=prevent
        self.content=content
        super.init(nibName: nil, bundle: nil)
        self.setUpUI()
        self.secureView.prevent=prevent
    }
    required init?(coder: NSCoder) {
        fatalError("SecureView: init(coder: NSCoder) has not been implemented")
    }
    
    private func setUpUI() {
        view.addSubview(self.secureView)
        self.secureView.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            self.secureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.secureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.secureView.topAnchor.constraint(equalTo: view.topAnchor),
            self.secureView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let host: UIHostingController=UIHostingController(rootView: self.content())
        host.view.translatesAutoresizingMaskIntoConstraints=false
        addChild(host)
        self.secureView.setUp(content: host.view)
        host.didMove(toParent: self)
    }
}
