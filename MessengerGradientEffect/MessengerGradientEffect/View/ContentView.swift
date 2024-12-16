//
//  ContentView.swift
//  MessengerGradientEffect
//
//  Created by 曾品瑞 on 2024/10/4.
//

import SwiftUI

struct ContentView: View {
    @ViewBuilder
    private func BottomView() -> some View {
        HStack(spacing: 20) {
            Button { } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.color4)
                    .frame(height: 25)
            }
            
            Button { } label: {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.color4)
                    .frame(height: 25)
            }
            
            Button { } label: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.color4)
                    .frame(height: 25)
            }
            
            Button { } label: {
                Image(systemName: "microphone.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.color4)
                    .frame(height: 25)
            }
            
            Capsule()
                .foregroundStyle(.gray.opacity(0.5))
                .frame(height: 40)
                .overlay {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.color4)
                        .frame(height: 25)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 10)
                }
            
            Image(systemName: "hand.thumbsup.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.color4)
                .frame(height: 25)
        }
        .padding(.horizontal)
        .padding(.top, 5)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HomeView()
                
                self.BottomView()
            }
            .toolbarBackground(.background, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { } label: {
                        HStack(spacing: 25) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.color1)
                                .frame(height: 20)
                                .bold()
                            
                            HStack {
                                Circle()
                                    .foregroundStyle(.color1)
                                    .frame(height: 40)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("CCU")
                                        .font(.title3)
                                        .foregroundStyle(Color.primary)
                                    
                                    Text("Active since 1989")
                                        .font(.callout)
                                        .foregroundStyle(Color.secondary)
                                }
                                .bold()
                            }
                        }
                        .padding(.bottom, 5)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 10) {
                        Button { } label: {
                            Image(systemName: "phone.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 25)
                        }
                        
                        Button { } label: {
                            Image(systemName: "video.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 25)
                        }
                    }
                    .foregroundStyle(.color1)
                }
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
