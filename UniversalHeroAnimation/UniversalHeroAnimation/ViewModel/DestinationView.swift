//
//  DestinationView.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct DestinationView<Content: View>: View {
    @EnvironmentObject private var hero: HeroModel
    
    var id: String
    @ViewBuilder var content: Content
    
    var index: Int? {
        if let index=self.hero.information.firstIndex(where: { $0.informationID==self.id }) {
            return index
        }
        return nil
    }
    var opacity: CGFloat {
        if let index {
            return self.hero.information[index].active ? (self.hero.information[index].hide ? 1:0):0
        }
        return 1
    }
    
    var body: some View {
        self.content
            .opacity(self.opacity)
            .anchorPreference(key: HeroKey.self, value: .bounds) { anchor in
                if let index, self.hero.information[index].active {
                    return ["\(self.id)DESTINATION":anchor]
                }
                return [:]
            }
            .onPreferenceChange(HeroKey.self) { value in
                if let index, self.hero.information[index].active {
                    self.hero.information[index].destinationAnchor=value["\(self.id)DESTINATION"]
                }
            }
    }
}
