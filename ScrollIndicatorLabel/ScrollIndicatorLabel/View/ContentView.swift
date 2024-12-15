//
//  ContentView.swift
//  ScrollIndicatorLabel
//
//  Created by 曾品瑞 on 2023/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: RectangleLabelView()) {
                    Text("Rectangle Label")
                }
                
                NavigationLink(destination: ContentLabelView()) {
                    Text("Content Label")
                }
            }
            .navigationTitle("Indicator")
        }
    }
}
