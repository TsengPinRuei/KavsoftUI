//
//  Snapshot.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//

import SwiftUI

struct Snapshot: ViewModifier {
    @State private var view: UIView=UIView(frame: .zero)
    
    var shot: Bool=false
    var complete: (UIImage) -> ()
    
    private func generateSnapshot() {
        if let view=self.view.superview?.superview {
            let renderer: UIGraphicsImageRenderer=UIGraphicsImageRenderer(size: view.bounds.size)
            let image: UIImage=renderer.image { _ in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
            
            self.complete(image)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(ViewExtractor(view: self.view))
            .compositingGroup()
            .onChange(of: self.shot) {
                self.generateSnapshot()
            }
    }
}
