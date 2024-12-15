//
//  ContentView.swift
//  ComplexScrollCalendar
//
//  Created by 曾品瑞 on 2023/11/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let safeArea: EdgeInsets=$0.safeAreaInsets
            
            HomeView(safeArea: safeArea).ignoresSafeArea(.container, edges: .top)
        }
    }
}
