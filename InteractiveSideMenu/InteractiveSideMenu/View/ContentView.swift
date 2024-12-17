//
//  ContentView.swift
//  InteractiveSideMenu
//
//  Created by 曾品瑞 on 2024/3/26.
//

import SwiftUI

let menuColor: Color=Color(red: 50/255, green: 50/255, blue: 50/255)

struct ContentView: View {
    enum Tab: String, CaseIterable {
        case home="house.fill"
        case favorite="heart.fill"
        case bookmark="bookmark.fill"
        case profile="person.crop.circle"
        case logout="rectangle.portrait.and.arrow.forward"
        
        var title: String {
            switch self {
            case .home: return "Home"
            case.favorite: return "Favorite"
            case .bookmark: return "Bookmark"
            case .profile: return "Profile"
            case .logout: return "Log Out"
            }
        }
    }
    
    @State private var show: Bool=false
    @State private var expand: Bool=true
    @State private var interact: Bool=true
    @State private var corner: CGFloat=20
    
    @ViewBuilder
    private func ButtonView(_ tab: Tab, tap: @escaping () -> ()={}) -> some View {
        Button(action: tap) {
            HStack(spacing: 10) {
                Image(systemName: tab.rawValue)
                
                Text(tab.title).font(.callout)
                
                Spacer(minLength: 0)
            }
            .font(.title3)
            .foregroundStyle(Color.primary)
            .padding(.vertical, 10)
            .contentShape(.rect)
        }
    }
    @ViewBuilder
    private func MenuView(_ safeArea: UIEdgeInsets) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Side Menu")
                .bold()
                .font(.largeTitle)
                .padding(.bottom, 10)
            
            self.ButtonView(.home)
            self.ButtonView(.favorite)
            self.ButtonView(.bookmark)
            self.ButtonView(.profile)
            
            Spacer(minLength: 0)
            
            self.ButtonView(.logout)
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .environment(\.colorScheme, .dark)
    }
    
    var body: some View {
        SideBar(
            expand: self.expand,
            interact: self.interact,
            corner: self.corner,
            show: self.$show
        ) {area in
            NavigationStack {
                List {
                    NavigationLink("Detail") {
                        Text("Hello, Justin!").navigationTitle("Detail")
                    }
                    
                    Section {
                        Toggle("3D Expand", isOn: self.$expand)
                        
                        Toggle("Disable Interact", isOn: self.$interact)
                        
                        HStack {
                            Stepper(
                                "Corner Radius (10)",
                                value: self.$corner,
                                in: 0...50, step: 10
                            )
                            
                            Text("\(Int(self.corner))")
                                .animation(.snappy, value: self.corner)
                                .contentTransition(.numericText(value: self.corner))
                        }
                    }
                }
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.show.toggle()
                        } label: {
                            Image(systemName: self.show ? "xmark":"line.3.horizontal")
                                .foregroundStyle(Color.primary)
                                .contentTransition(.symbolEffect)
                        }
                    }
                }
            }
        } menu: {area in
            self.MenuView(area)
        } background: {
            Rectangle().fill(InteractiveSideMenu.menuColor)
        }
    }
}

#Preview {
    ContentView()
}
