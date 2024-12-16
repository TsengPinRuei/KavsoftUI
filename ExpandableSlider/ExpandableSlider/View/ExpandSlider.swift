//
//  ExpandSlider.swift
//  ExpandableSlider
//
//  Created by 曾品瑞 on 2024/11/17.
//

import SwiftUI

struct ExpandSlider<Overlay: View>: View {
    struct Configuration {
        var cornerRadius: CGFloat=10
        var height: CGFloat=20
        var activeTint: Color=Color.primary
        var inTint: Color=Color.black.opacity(0.1)
        var overlayActiveTint: Color=Color.white
        var overlayInTint: Color=Color.black
    }
    
    @Binding var value: CGFloat
    
    @GestureState var active: Bool=false
    
    @State private var lastValue: CGFloat
    
    var range: ClosedRange<CGFloat>
    var overlay: Overlay
    var configuration: Configuration
    
    init(
        value: Binding<CGFloat>,
        in range: ClosedRange<CGFloat>,
        configuration: Configuration=Configuration(),
        @ViewBuilder overlay: () -> Overlay
    ) {
        self._value=value
        self.lastValue=value.wrappedValue
        self.range=range
        self.configuration=configuration
        self.overlay=overlay()
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            let width: CGFloat=self.value/self.range.upperBound*size.width
            
            ZStack(alignment: .leading) {
                Rectangle().fill(self.configuration.inTint)
                
                Rectangle()
                    .fill(self.configuration.activeTint)
                    .mask(alignment: .leading) {
                        Rectangle().frame(width: width)
                    }
                
                ZStack(alignment: .leading) {
                    self.overlay.foregroundStyle(self.configuration.overlayInTint)
                    
                    self.overlay
                        .foregroundStyle(self.configuration.overlayActiveTint)
                        .mask(alignment: .leading) {
                            Rectangle().frame(width: width)
                        }
                }
                .compositingGroup()
                .animation(.easeInOut(duration: 0.3).delay(self.active ? 0.1:0).speed(self.active ? 1:2)) {
                    $0.opacity(self.active ? 1:0)
                }
            }
            .contentShape(.rect)
            .highPriorityGesture(
                DragGesture(minimumDistance: 0)
                    .updating(self.$active) { (_, out, _) in
                        out=true
                    }
                    .onChanged { value in
                        let progress: CGFloat=value.translation.width/size.width*self.range.upperBound+self.lastValue
                        self.value=max(min(progress, self.range.upperBound), self.range.lowerBound)
                    }
                    .onEnded { _ in
                        self.lastValue=self.value
                    }
            )
        }
        .frame(height: 20+self.configuration.height)
        .mask {
            RoundedRectangle(cornerRadius: self.configuration.cornerRadius).frame(height: 20+(self.active ? self.configuration.height:0)).animation(.snappy, value: self.active)
        }
        .animation(.snappy, value: self.active)
    }
}
