//
//  UICoordinator.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/12.
//

import SwiftUI

@Observable
class UICoordinator {
    var nature: [Nature]=PhotoTransition.nature.compactMap {
        Nature(title: $0.title, image: $0.image, preview: $0.image)
    }
    var current: Nature?
    var animate: Bool=false
    var show: Bool=false
    var scrollPosition: String?
    var indicatorPosition: String?
    var offset: CGSize=CGSize.zero
    var progress: CGFloat=0
    
    func indicatorChange() {
        if let nature=self.nature.first(where: { $0.id==self.indicatorPosition }) {
            self.current=nature
            self.scrollPosition=nature.id
        }
    }
    func scrollChange() {
        if let nature=self.nature.first(where: { $0.id==self.scrollPosition }) {
            self.current=nature
            withAnimation(.easeInOut(duration: 0.1)) {
                self.indicatorPosition=nature.id
            }
        }
    }
    func reset() {
        self.current=nil
        self.scrollPosition=nil
        self.offset=CGSize.zero
        self.progress=0
        self.indicatorPosition=nil
    }
    func toggle(show: Bool, slow: Bool) {
        if(show) {
            self.scrollPosition=self.current?.id
            self.indicatorPosition=self.current?.id
            withAnimation(slow ? .easeInOut(duration: 2):.easeInOut.speed(2), completionCriteria: .removed) {
                self.animate=true
            } completion: {
                self.show=true
            }
        } else {
            self.show=false
            withAnimation(slow ? .easeInOut(duration: 2):.easeInOut.speed(2), completionCriteria: .removed) {
                self.animate=false
                self.offset=CGSize.zero
            } completion: {
                self.reset()
            }
        }
    }
}
