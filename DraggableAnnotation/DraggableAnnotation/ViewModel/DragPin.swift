//
//  DragPin.swift
//  DraggableAnnotation
//
//  Created by 曾品瑞 on 2024/3/3.
//

import SwiftUI
import MapKit

struct DragPin: View {
    @Binding var coordinate: CLLocationCoordinate2D
    
    @State private var active: Bool=false
    @State private var translation: CGSize=CGSize.zero
    
    var proxy: MapProxy
    var tint: Color=Color.red
    var coordinateChange: (CLLocationCoordinate2D) -> ()
    
    var body: some View {
        GeometryReader {
            let frame: CGRect=$0.frame(in: .global)
            
            Image(systemName: "mappin")
                .font(.title)
                .foregroundStyle(self.tint.gradient)
                .frame(width: frame.width, height: frame.height)
                .animation(.snappy) {content in
                    content.scaleEffect(self.active ? 1.5:1, anchor: .bottom)
                }
                .onChange(of: self.active) {(_, new) in
                    let position: CGPoint=CGPoint(x: frame.midX, y: frame.midY)
                    
                    if let coordinate=self.proxy.convert(position, from: .global), !new {
                        self.coordinate=coordinate
                        self.translation=CGSize.zero
                        self.coordinateChange(coordinate)
                    }
                }
        }
        .frame(width: 30, height: 30)
        .contentShape(.rect)
        .offset(self.translation)
        .gesture(
            LongPressGesture(minimumDuration: 0.2)
                .onEnded {
                    self.active=$0
                }
                .simultaneously(with: DragGesture(minimumDistance: 0)
                    .onChanged {value in
                        if(self.active) { self.translation=value.translation }
                    }
                    .onEnded {value in
                        if(self.active) { self.active=false }
                    }
                )
        )
    }
}
