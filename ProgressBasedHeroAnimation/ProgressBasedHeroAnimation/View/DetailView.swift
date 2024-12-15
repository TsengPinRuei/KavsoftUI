//
//  DetailView.swift
//  ProgressBasedHeroAnimation
//
//  Created by 曾品瑞 on 2023/10/17.
//

import SwiftUI

struct DetailView: View {
    @Binding var showDetail: Bool
    @Binding var showHero: Bool
    @Binding var progress: CGFloat
    @Binding var profile: Profile?
    
    @Environment(\.colorScheme) private var scheme
    
    @GestureState private var drag: Bool=false
    
    @State private var offset: CGFloat = .zero
    
    var body: some View {
        if let profile=self.profile, self.showDetail {
            GeometryReader {
                let size=$0.size
                
                ScrollView(.vertical) {
                    Rectangle()
                        .fill(.clear)
                        .overlay {
                            if(!self.showHero) {
                                Image(profile.picture)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: size.width, height: 400)
                                    .clipShape(.rect(cornerRadius: 25))
                                    .transition(.identity)
                            }
                        }
                        .frame(height: 400)
                        .anchorPreference(key: AnchorKey.self, value: .bounds) {anchor in
                            return ["DESTINATION":anchor]
                        }
                        .visualEffect {(content, proxy) in
                            content
                                .offset(y: proxy.frame(in: .scrollView).minY>0 ? -proxy.frame(in: .scrollView).minY:0)
                        }
                }
                .scrollIndicators(.hidden)
                .ignoresSafeArea(.all)
                .frame(width: size.width, height: size.height)
                .background {
                    Rectangle()
                        .fill(self.scheme == .dark ? .black:.white)
                        .ignoresSafeArea(.all)
                }
                .overlay(alignment: .topLeading) {
                    Button {
                        self.showHero=true
                        withAnimation(.snappy(duration: 0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
                            self.progress=0
                        } completion: {
                            self.showDetail=false
                            self.profile=nil
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .imageScale(.medium)
                            .contentShape(.rect)
                            .foregroundStyle(.white, .black)
                    }
                    .buttonStyle(.plain)
                    .padding()
                    .opacity(self.showHero ? 0:1)
                    .animation(.snappy(duration: 0.2, extraBounce: 0), value: self.showHero)
                }
                .offset(x: size.width-(size.width*self.progress))
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 10)
                        .contentShape(.rect)
                        .gesture(
                            DragGesture()
                                .updating(self.$drag) {(_, out, _) in
                                    out=true
                                }
                                .onChanged {value in
                                    var translation=value.translation.width
                                    
                                    translation=self.drag ? translation:.zero
                                    translation=translation>0 ? translation:0
                                    
                                    let dragProgress=1-(translation/size.width)
                                    let cappedProgress=min(max(0, dragProgress), 1)
                                    
                                    self.progress=cappedProgress
                                    if(!self.showHero) {
                                        self.showHero=true
                                    }
                                }
                                .onEnded {value in
                                    let velocity=value.velocity.width
                                    
                                    if(self.offset+velocity>size.width*0.8) {
                                        withAnimation(.snappy(duration: 0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
                                            self.progress = .zero
                                        } completion: {
                                            self.offset = .zero
                                            self.showDetail=false
                                            self.showHero=true
                                            self.profile=nil
                                        }
                                    } else {
                                        withAnimation(.snappy(duration: 0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
                                            self.progress=1
                                            self.offset = .zero
                                        } completion: {
                                            self.showHero=false
                                        }
                                    }
                                }
                        )
                }
            }
        }
    }
}
