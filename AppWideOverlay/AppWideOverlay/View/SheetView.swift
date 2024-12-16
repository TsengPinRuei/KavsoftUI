//
//  SheetView.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

struct SheetView: View {
    @State private var show: Bool=false
    
    let count: Int
    
    var body: some View {
        NavigationStack {
            List {
                Button("Sheet") {
                    self.show.toggle()
                }
            }
            .navigationTitle("\(self.count)")
            .sheet(isPresented: self.$show) {
                SheetView(count: self.count+1)
            }
        }
    }
}
