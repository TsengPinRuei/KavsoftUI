//
//  ContentView.swift
//  DynamicNotification
//
//  Created by 曾品瑞 on 2023/10/27.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet: Bool=false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Sheet") {
                    self.showSheet.toggle()
                }
                .sheet(isPresented: self.$showSheet) {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        
                        Button("Show AirDrop Notification") {
                            UIApplication.shared.dynamicNotification(dynamicIsland: true, timeout: 5, swipeToDismiss: true) {
                                HStack {
                                    Image(systemName: "wifi")
                                        .font(.system(size: 50))
                                        .foregroundStyle(.white)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("AirDrop")
                                            .bold()
                                            .font(.callout)
                                            .foregroundStyle(.white)
                                        
                                        Text("From Justin")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.top, 20)
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(15)
                                .background {
                                    RoundedRectangle(cornerRadius: 15).fill(.black)
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.orange)
                    }
                    .presentationDetents([.fraction(0.2)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.2)))
                }
                
                Button("Show Notification") {
                    UIApplication.shared.dynamicNotification(dynamicIsland: true, timeout: 5, swipeToDismiss: true) {
                        HStack {
                            Image(.patrick)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(.circle)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Justin")
                                    .bold()
                                    .font(.callout)
                                    .foregroundStyle(.white)
                                
                                Text("Hello, world!")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.top, 20)
                            
                            Spacer(minLength: 0)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "speaker.slash.fill").font(.title)
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.circle)
                            .tint(.white)
                        }
                        .padding(15)
                        .background {
                            RoundedRectangle(cornerRadius: 15).fill(.black)
                        }
                    }
                }
                .buttonStyle(.bordered)
            }
            .font(.title)
            .navigationTitle("Dynamic Notification")
        }
    }
}
