//
//  UICoordinator.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

@Observable
class UICoordinator {
    var scrollView: UIScrollView=UIScrollView(frame: CGRect.zero)
    var rect: CGRect=CGRect.zero
    var layer: UIImage?
    var animate: Bool=false
    var hide: Bool=false
    var root: Bool=false
    var current: Nature?
    var header: CGFloat=CGFloat.zero
    
    func create() {
        let renderer: UIGraphicsImageRenderer=UIGraphicsImageRenderer(size: self.scrollView.bounds.size)
        let image: UIImage=renderer.image {image in
            image.cgContext.translateBy(x: -self.scrollView.contentOffset.x, y: -self.scrollView.contentOffset.y)
            self.scrollView.layer.render(in: image.cgContext)
        }
        self.layer=image
    }
    private func reset() {
        self.header=0
        self.current=nil
        self.layer=nil
        self.root=false
    }
    func toggle(show: Bool, slow: Bool, frame: CGRect, nature: Nature) {
        if(show) {
            self.current=nature
            self.rect=frame
            self.create()
            self.root=true
            withAnimation(.easeInOut(duration: slow ? 2:0.3), completionCriteria: .removed) {
                self.animate=true
            } completion: {
                self.hide=true
            }
        } else {
            self.hide=false
            withAnimation(.easeInOut(duration: slow ? 2:0.3), completionCriteria: .removed) {
                self.animate=false
            } completion: {
                DispatchQueue.main.async {
                    self.reset()
                }
            }
        }
    }
}
