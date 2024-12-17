//
//  ContentView.swift
//  DraggableAnnotation
//
//  Created by 曾品瑞 on 2024/3/3.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var display: Bool=false
    @State private var update: Bool=false
    @State private var title: String=""
    @State private var coordinate: CLLocationCoordinate2D=CLLocationCoordinate2D.applePark
    @State private var position: MapCameraPosition=MapCameraPosition.region(MKCoordinateRegion(center: .applePark, span: .initial))
    @State private var span: MKCoordinateSpan=MKCoordinateSpan.initial
    
    private func findTitle() {
        self.title=""
        Task {
            let location: CLLocation=CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
            let decoder: CLGeocoder=CLGeocoder()
            if let name=try? await decoder.reverseGeocodeLocation(location).first?.name {
                self.title=name
            }
        }
    }
    
    var body: some View {
        MapReader {reader in
            Map(position: self.$position) {
                Annotation(self.display ? self.title:"", coordinate: self.coordinate) {
                    DragPin(coordinate: self.$coordinate, proxy: reader) {coordinate in
                        self.findTitle()
                        guard self.update else { return }
                        
                        let region: MKCoordinateRegion=MKCoordinateRegion(center: coordinate, span: self.span)
                        withAnimation(.smooth) {
                            self.position=MapCameraPosition.region(region)
                        }
                    }
                }
            }
            .onMapCameraChange(frequency: .continuous) {value in
                self.span=value.region.span
            }
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 0) {
                    Toggle("Update Camera", isOn: self.$update).frame(width: 170)
                    
                    Spacer(minLength: 0)
                    
                    Toggle("Display Title", isOn: self.$display).frame(width: 150)
                }
                .textScale(.secondary)
                .padding(10)
                .background(.ultraThinMaterial)
            }
            .onAppear(perform: self.findTitle)
        }
    }
}

#Preview {
    ContentView()
}
