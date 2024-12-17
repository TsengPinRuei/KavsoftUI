//
//  ContentView.swift
//  MapBottomSheet
//
//  Created by 曾品瑞 on 2024/3/4.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var ignoreTab: Bool=false
    @State private var show: Bool=false
    @State private var active: BottomTab=BottomTab.device
    
    @ViewBuilder
    private func TabBarView() -> some View {
        HStack(spacing: 0) {
            ForEach(BottomTab.allCases, id: \.rawValue) {tab in
                Button {
                    withAnimation(.easeInOut) {
                        self.active=tab
                    }
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: tab.symbol).font(.title2)
                        
                        Text(tab.rawValue).font(.caption)
                    }
                    .foregroundStyle(self.active==tab ? Color.accentColor:Color.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(initialPosition: .region(.applePark))
            
            self.TabBarView()
                .frame(height: 50)
                .background(.ultraThinMaterial)
        }
        .task {
            self.show=true
        }
        .sheet(isPresented: self.$show) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: self.ignoreTab ? 0:20) {
                    Text(self.active.rawValue)
                        .font(.title)
                        .fontWeight(.semibold)
                        .contentTransition(.numericText())
                    
                    Toggle("Ignore Bottom Tab Bar", isOn: self.$ignoreTab)
                }
                .padding()
                .animation(.easeInOut, value: self.ignoreTab)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .presentationDetents([.height(60), .medium, .large])
            .presentationBackground(.ultraThinMaterial)
            .presentationCornerRadius(20)
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
            .interactiveDismissDisabled()
            .bottomMask(mask: !self.ignoreTab)
        }
    }
}

#Preview {
    ContentView()
}
