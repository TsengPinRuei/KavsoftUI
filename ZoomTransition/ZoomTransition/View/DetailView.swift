//
//  DetailView.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI

struct DetailView: View {
    var animation: Namespace.ID
    var nature: Nature
    
    @Environment(NatureModel.self) private var model
    
    @State private var hide: Bool=false
    @State private var id: UUID?
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            Color.black
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(self.model.nature) {nature in
                        PlayerView(nature: nature).frame(width: size.width, height: size.height)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: self.$id)
            .scrollTargetBehavior(.paging)
            .zIndex(self.hide ? 1:0)
            
            if let image=self.nature.image, !self.hide {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                //.clipShape(.rect(cornerRadius: 20))
                    .task {
                        self.id=self.nature.id
                        try? await Task.sleep(for: .seconds(0.2))
                        self.hide=true
                    }
            }
        }
        .ignoresSafeArea()
        .navigationTransition(.zoom(sourceID: self.hide ? self.id ?? self.nature.id:self.nature.id, in: self.animation))
    }
}
