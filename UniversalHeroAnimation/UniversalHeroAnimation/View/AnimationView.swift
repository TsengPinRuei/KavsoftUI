//
//  AnimationView.swift
//  UniversalHeroAnimation
//
//  Created by 曾品瑞 on 2024/2/21.
//

import SwiftUI

struct AnimationView: View {
    @State private var show: Bool=false
    
    let fullScreenCover: Bool
    let sheet: Bool
    var item: Item
    
    @ViewBuilder
    private func ImageView() -> some View {
        Image(systemName: self.item.symbol)
            .font(.title2)
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(self.item.color.gradient, in: .circle)
    }
    private func BodyView() -> some View {
        HStack {
            SourceView(id: self.item.id.uuidString) {
                self.ImageView()
            }
            
            Text(self.item.title)
            
            Spacer(minLength: 0)
        }
        .contentShape(.rect)
        .onTapGesture {
            self.show.toggle()
        }
        .heroLayer(id: self.item.id.uuidString, animate: self.$show) {
            self.ImageView()
        } completion: { _ in }
    }
    
    var body: some View {
        if(self.fullScreenCover) {
            self.BodyView()
                .fullScreenCover(isPresented: self.$show) {
                    DestinationView(id: self.item.id.uuidString) {
                        self.ImageView()
                            .onTapGesture {
                                self.show.toggle()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
                    .interactiveDismissDisabled()
                }
        } else if(self.sheet) {
            self.BodyView()
                .sheet(isPresented: self.$show) {
                    DestinationView(id: self.item.id.uuidString) {
                        self.ImageView()
                            .onTapGesture {
                                self.show.toggle()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
                    .interactiveDismissDisabled()
                }
        } else {
            self.BodyView()
                .navigationDestination(isPresented: self.$show) {
                    DestinationView(id: self.item.id.uuidString) {
                        self.ImageView()
                            .onTapGesture {
                                self.show.toggle()
                            }
                    }
                    .navigationTitle("Animation Done")
                    .navigationBarBackButtonHidden()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
                }
        }
    }
}
