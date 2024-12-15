//
//  HomeView.swift
//  ScrollableTabView
//
//  Created by 曾品瑞 on 2023/11/9.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) private var scheme
    
    @State private var progress: CGFloat=0
    @State private var select: Tab?
    
    @ViewBuilder
    private func DisplayRectangle(width: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(.ultraThinMaterial)
            .frame(width: width, height: 10)
    }
    @ViewBuilder
    private func DisplayView(_ color: Color) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(1...10, id: \.self) {_ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.gradient)
                        .frame(height: 150)
                        .overlay {
                            VStack(alignment: .leading) {
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    self.DisplayRectangle(width: 80)
                                    
                                    self.DisplayRectangle(width: 60)
                                }
                                
                                Spacer(minLength: 0)
                                
                                self.DisplayRectangle(width: 40).frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .mask {
            Rectangle().padding(.bottom, -100)
        }
    }
    @ViewBuilder
    private func TabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {tab in
                HStack(spacing: 10) {
                    Image(systemName: tab.image)
                    
                    Text(tab.rawValue).font(.callout)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        self.select=tab
                    }
                }
            }
        }
        .tabMask(self.progress)
        .background {
            GeometryReader {
                let size=$0.size
                let capsuleWidth=size.width/CGFloat(Tab.allCases.count)
                
                Capsule()
                    .fill(self.scheme == .dark ? .black:.white)
                    .frame(width: capsuleWidth)
                    .offset(x: self.progress*(size.width-capsuleWidth))
            }
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "bell.badge")
                }
            }
            .font(.title2)
            .overlay {
                Text("Message")
                    .bold()
                    .font(.title3)
            }
            .foregroundStyle(.primary)
            .padding()
            
            self.TabBar()
            
            GeometryReader {
                let size=$0.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        self.DisplayView(.blue)
                            .id(Tab.call)
                            .containerRelativeFrame(.horizontal)
                        
                        self.DisplayView(.green)
                            .id(Tab.chat)
                            .containerRelativeFrame(.horizontal)
                        
                        self.DisplayView(.red)
                            .id(Tab.setting)
                            .containerRelativeFrame(.horizontal)
                    }
                    .scrollTargetLayout()
                    .offsetX {value in
                        let progress: CGFloat = -value/(size.width*CGFloat(Tab.allCases.count-1))
                        self.progress=max(min(progress, 1), 0)
                    }
                }
                .scrollPosition(id: self.$select)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .scrollClipDisabled()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.gray.opacity(0.1))
    }
}
