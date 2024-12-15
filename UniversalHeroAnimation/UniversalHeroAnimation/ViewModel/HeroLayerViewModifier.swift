//
//  HeroLayerViewModifier.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct HeroLayerViewModifier<Layer: View>: ViewModifier {
    @EnvironmentObject private var hero: HeroModel
    
    let id: String
    @Binding var animate: Bool
    var sourceRadius: CGFloat=0
    var destinationRadius: CGFloat=0
    
    @ViewBuilder var layer: Layer
    
    var completion: (Bool) -> ()
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if(!self.hero.information.contains(where: { $0.informationID==self.id })) {
                    self.hero.information.append(HeroInformation(id: self.id))
                }
            }
            .onChange(value: self.animate) { value in
                if let index=self.hero.information.firstIndex(where: { $0.informationID==self.id }) {
                    self.hero.information[index].active=true
                    self.hero.information[index].layer=AnyView(self.layer)
                    self.hero.information[index].sourceRadius=self.sourceRadius
                    self.hero.information[index].destinationRadius=self.destinationRadius
                    self.hero.information[index].completion=self.completion
                    
                    if(value) {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.06) {
                            withAnimation(.snappy(duration: 0.35, extraBounce: 0)) {
                                self.hero.information[index].animate=true
                            }
                        }
                    } else {
                        self.hero.information[index].hide=false
                        withAnimation(.snappy(duration: 0.35, extraBounce: 0)) {
                            self.hero.information[index].animate=false
                        }
                    }
                }
            }
    }
}
