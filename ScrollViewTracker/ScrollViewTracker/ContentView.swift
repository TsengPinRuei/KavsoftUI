//
//  ContentView.swift
//  ScrollViewTracker
//
//  Created by 曾品瑞 on 2023/11/29.
//

import SwiftUI

struct ContentView: View {
    @State private var scrollOffset: CGFloat=0
    
    private var color: [Color]=[.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        GeometryReader {outReader in
            ScrollViewReader {scroll in
                ZStack {
                    ScrollView {
                        VStack {
                            GeometryReader {inReader in
                                Color.clear
                                    .preference(key: ScrollOffsetKey.self, value: inReader.frame(in: .named("scrollView")).minY)
                            }
                            .frame(height: 0)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                                ForEach(0..<25, id: \.self) {index in
                                    RoundedRectangle(cornerRadius: 20)
                                        .scaledToFit()
                                        .foregroundStyle(self.color[index%self.color.count])
                                        .id(index)
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .coordinateSpace(name: "scrollView")
                    .onPreferenceChange(ScrollOffsetKey.self) {value in
                        self.scrollOffset=min(1, max(0, -value/(180*25/2-outReader.size.height)))
                    }
                    
                    ZStack {
                        Group {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundStyle(.black)
                                    .frame(width: 250, height: 50)
                                
                                HStack {
                                    Text("\(Int(self.scrollOffset*100))%")
                                        .bold()
                                        .foregroundStyle(.white)
                                        .contentTransition(.numericText())
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.green)
                                        .frame(width: 150*self.scrollOffset, height: 10)
                                }
                                .padding(.leading, 20)
                                .opacity((self.scrollOffset>0 && self.scrollOffset<1) ? 1:0)
                            }
                        }
                        .opacity(self.scrollOffset>0 ? 0.8:0)
                        .animation(.smooth, value: self.scrollOffset)
                        
                        Button {
                            withAnimation(.smooth) {
                                scroll.scrollTo(0, anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .bold()
                                .font(.title)
                                .foregroundStyle(.white)
                                .frame(width: 50, height: 50)
                        }
                        .offset(y: self.scrollOffset==1 ? 0:100)
                        .animation(.bouncy, value: self.scrollOffset)
                    }
                    .mask {
                        RoundedRectangle(cornerRadius: 50)
                            .frame(width: (self.scrollOffset>0 && self.scrollOffset<1) ? 250:50, height: 50)
                            .animation(.smooth, value: self.scrollOffset)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
    }
}
