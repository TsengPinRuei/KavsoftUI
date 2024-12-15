//
//  HomeView.swift
//  AnimaitonTextField
//
//  Created by 曾品瑞 on 2023/12/19.
//

import SwiftUI
import Combine

struct HomeView: View {
    @State private var click: Bool=false
    @State private var text: String=""
    
    private func limitText(_ limit: Int) {
        if(self.text.count>limit) {
            self.text=String(self.text.prefix(limit))
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle().fill(.gray.gradient).ignoresSafeArea()
            
            VStack {
                VStack(spacing: 5) {
                    TextField("", text: self.$text) {status in
                        if(status) {
                            withAnimation(.smooth) {
                                self.click=true
                            }
                        }
                    } onCommit: {
                        if(self.text.isEmpty) {
                            withAnimation(.smooth) {
                                self.click=false
                            }
                        }
                    }
                    .onReceive(Just(self.text)) {_ in
                        self.limitText(20)
                    }
                    .background(alignment: .leading) {
                        Text("User Name")
                            .bold(self.click)
                            .foregroundStyle(self.click ? .black:.gray)
                            .offset(x: self.click ? -10:0, y: self.click ? -25:0)
                    }
                    
                    Rectangle()
                        .fill(.black)
                        .opacity(self.click ? 1:0)
                        .frame(height: 1)
                        .padding(.horizontal, -8)
                }
                .padding([.vertical, .trailing], 10)
                .padding(.leading)
                .padding(.top, self.click ? 20:0)
                .background(.ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 10))
                
                HStack {
                    Spacer()
                    
                    Text("\(self.text.count) / 20")
                        .font(.callout)
                        .foregroundStyle(.black)
                }
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
