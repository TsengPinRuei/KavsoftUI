//
//  PreventView.swift
//  ScreenshotPreventation
//
//  Created by 曾品瑞 on 2024/1/7.
//

import UIKit

public final class PreventView: UIView {
    private let text: UITextField=UITextField()
    private var content: UIView?
    
    public var prevent: Bool=true {
        didSet {
            self.text.isSecureTextEntry=self.prevent
        }
    }
    private lazy var secure: UIView?=try? self.getSecure()
    
    public override var isUserInteractionEnabled: Bool {
        didSet {
            self.secure?.isUserInteractionEnabled=self.isUserInteractionEnabled
        }
    }
    
    public init(content: UIView?=nil) {
        self.content=content
        super.init(frame: .zero)
        self.setUpUI()
    }
    required init?(coder decoder: NSCoder) {
        fatalError()
    }
    
    private func getSecure() throws -> UIView? {
        return self.text.subviews.filter {view in
            type(of: view).description()=="_UITextLayoutCanvasView"
        }.first
    }
    public func setUp(content: UIView) {
        self.content?.removeFromSuperview()
        self.content=content
        
        guard let view=self.secure else { return }
        view.addSubview(content)
        view.isUserInteractionEnabled=self.isUserInteractionEnabled
        content.translatesAutoresizingMaskIntoConstraints=false
        
        let bottom: NSLayoutConstraint=content.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottom.priority = UILayoutPriority.required-1
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            content.topAnchor.constraint(equalTo: view.topAnchor),
            bottom
        ])
    }
    private func setUpUI() {
        self.text.backgroundColor=UIColor.clear
        self.text.isUserInteractionEnabled=false
        
        guard let view=self.secure else { return }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
