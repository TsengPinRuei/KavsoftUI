//
//  Nature.swift
//  PhotoTransition
//
//  Created by 曾品瑞 on 2024/5/12.
//

import SwiftUI

struct Nature: Identifiable, Hashable {
    var id: String=UUID().uuidString
    var title: String
    var image: UIImage?
    var preview: UIImage?
    var appear: Bool=false
}

var nature: [Nature] {
    var result: [Nature]=[]
    
    for i in 1...15 {
        result.append(Nature(title: "Nature \(i)", image: UIImage(named: "nature\(i)")))
    }
    
    return result
}
