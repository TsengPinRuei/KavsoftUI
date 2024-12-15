//
//  ContentView.swift
//  NavigationToRoot
//
//  Created by 曾品瑞 on 2024/2/27.
//

import SwiftUI

struct ContentView: View {
    @State private var count: Int=0
    @State private var homeStack: NavigationPath=NavigationPath()
    @State private var settingStack: NavigationPath=NavigationPath()
    @State private var tab: Tab=Tab.home
    
    var select: Binding<Tab> {
        return Binding { self.tab } set: {value in
            if(value==self.tab) {
                self.count+=1
                if(self.count==2) {
                    switch(value) {
                    case .home: self.homeStack=NavigationPath()
                    case .setting: self.settingStack=NavigationPath()
                    }
                    self.count=0
                }
            } else {
                self.count=0
            }
            
            self.tab=value
        }
    }
    
    @ViewBuilder
    private func LinkView(value: String) -> some View {
        List {
            NavigationLink(value, value: "\(Int(value)!+1)")
        }
        .navigationTitle(value)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Double Tap To Get Back To 0 View").bold()
            }
        }
    }
    
    var body: some View {
        TabView(selection: self.select) {
            NavigationStack(path: self.$homeStack) {
                self.LinkView(value: "0")
                    .navigationDestination(for: String.self) {current in
                        self.LinkView(value: current)
                    }
                
            }
            .tag(Tab.home)
            .tabItem {
                Image(systemName: Tab.home.symbol)
                Text(Tab.home.rawValue)
            }
            
            NavigationStack(path: self.$settingStack) {
                ZStack {
                }
                .navigationTitle("Setting")
            }
            .tag(Tab.setting)
            .tabItem {
                Image(systemName: Tab.setting.symbol)
                Text(Tab.setting.rawValue)
            }
        }
    }
}
