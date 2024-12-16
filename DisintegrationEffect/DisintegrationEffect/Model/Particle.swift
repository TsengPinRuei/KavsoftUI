//
//  Particle.swift
//  DisintegrationEffect
//
//  Created by 曾品瑞 on 2024/12/3.
//

import SwiftUI

struct Particle: Identifiable {
    var id: String=UUID().uuidString
    var image: UIImage
    var offset: CGSize
}
