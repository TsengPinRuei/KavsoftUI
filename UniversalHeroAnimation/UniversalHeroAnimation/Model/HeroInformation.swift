//
//  HeroInformation.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct HeroInformation: Identifiable {
    private(set) var id: UUID=UUID()
    private(set) var informationID: String
    var active: Bool=false
    var layer: AnyView?
    var animate: Bool=false
    var hide: Bool=false
    var sourceAnchor: Anchor<CGRect>?
    var destinationAnchor: Anchor<CGRect>?
    var sourceRadius: CGFloat=0
    var destinationRadius: CGFloat=0
    var completion: (Bool) -> ()={ _ in }
    
    init(id: String) {
        self.informationID=id
    }
}
