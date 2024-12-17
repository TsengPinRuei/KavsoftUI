//
//  MKCoordinateRegion.swift
//  MapBottomSheet
//
//  Created by 曾品瑞 on 2024/3/5.
//

import SwiftUI
import MapKit

extension MKCoordinateRegion {
    static var applePark: MKCoordinateRegion {
        let center: CLLocationCoordinate2D=CLLocationCoordinate2D(latitude: 37.334606, longitude: -122.009102)
        return MKCoordinateRegion(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
