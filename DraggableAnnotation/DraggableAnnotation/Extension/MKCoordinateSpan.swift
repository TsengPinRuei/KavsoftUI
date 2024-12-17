//
//  MKCoordinateSpan.swift
//  DraggableAnnotation
//
//  Created by 曾品瑞 on 2024/3/3.
//

import SwiftUI
import MapKit

extension MKCoordinateSpan {
    static var initial: MKCoordinateSpan {
        return MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
}
