//
//  ContentView.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var show: Bool=false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(UniversalHeroAnimation.fullScreenCoverView) { view in
                        AnimationView(fullScreenCover: true, sheet: false, item: view)
                    }
                } header: {
                    Text("Full Screen Cover")
                }
                .headerProminence(.increased)
                
                Section {
                    ForEach(UniversalHeroAnimation.navigationLinkView) { view in
                        AnimationView(fullScreenCover: false, sheet: false, item: view)
                    }
                } header: {
                    Text("Navigation Link")
                }
                .headerProminence(.increased)
                
                Section {
                    ForEach(UniversalHeroAnimation.sheetView) { view in
                        AnimationView(fullScreenCover: false, sheet: true, item: view)
                    }
                } header: {
                    Text("Sheet")
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Animation Start")
        }
    }
}
