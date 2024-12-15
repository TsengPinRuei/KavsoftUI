//
//  DetailView.swift
//  SynchronizedHeroAnimation
//
//  Created by 曾品瑞 on 2023/12/7.
//

import SwiftUI

struct DetailView: View {
    @Binding var show: Bool
    @Binding var animation: Bool
    @Binding var id: UUID?
    
    @State private var scrollPosition: UUID?
    @State private var start1: DispatchWorkItem?
    @State private var start2: DispatchWorkItem?
    
    var post: Post
    var updateScrollPosition: (UUID?) -> ()
    
    private func cancelTask() {
        if let start1, let start2 {
            start1.cancel()
            start2.cancel()
            self.start1=nil
            self.start2=nil
        }
    }
    private func initiateTask(reference: inout DispatchWorkItem?, task: DispatchWorkItem, duration: CGFloat) {
        reference=task
        DispatchQueue.main.asyncAfter(deadline: .now()+duration, execute: task)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(self.post.landscape) {landscape in
                    Image(landscape.image)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal)
                        .clipped()
                        .anchorPreference(key: OffsetKey.self, value: .bounds) {anchor in
                            return ["DESTINATION\(landscape.id.uuidString)":anchor]
                        }
                        .opacity(self.id==landscape.id ? 0:1)
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: self.$scrollPosition)
        .background(.black)
        .opacity(self.animation ? 1:0)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .overlay(alignment: .topLeading) {
            Button("", systemImage: "xmark.circle.fill") {
                self.cancelTask()
                
                self.updateScrollPosition(self.scrollPosition)
                self.id=self.scrollPosition
                self.initiateTask(reference: &self.start1, task: DispatchWorkItem(block: {
                    withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                        self.animation=false
                    }
                    
                    self.initiateTask(reference: &self.start2, task: DispatchWorkItem(block: {
                        self.show=false
                        self.id=nil
                    }), duration: 0.3)
                }), duration: 0.05)
            }
            .font(.title)
            .foregroundStyle(.white.opacity(0.8), .white.opacity(0.2))
            .padding()
        }
        .onAppear {
            self.cancelTask()
            
            guard self.scrollPosition==nil else { return }
            
            self.scrollPosition=self.id
            self.initiateTask(reference: &self.start1, task: DispatchWorkItem(block: {
                withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                    self.animation=true
                }
                
                self.initiateTask(reference: &self.start2, task: DispatchWorkItem(block: {
                    self.id=nil
                }), duration: 0.3)
            }), duration: 0.05)
        }
    }
}
