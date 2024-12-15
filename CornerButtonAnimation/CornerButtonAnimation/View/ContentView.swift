//
//  ContentView.swift
//  CornerButtonAnimation
//
//  Created by 曾品瑞 on 2023/11/10.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    
    @State private var show: Bool=false
    @State private var showView: Bool=false
    @State private var title: String=""
    @State private var content: String=""
    @State private var scale: CGFloat=1
    @State private var newOffset: CGSize=CGSize.zero
    @State private var oldOffset: CGSize=CGSize.zero
    @State private var selectColor: Color=Color.red
    @State private var color: [Color]=[.red, .orange, .yellow, .green, .blue, .purple, .brown]
    @State private var task: [Tasks]=[]
    
    private let buttonBackground: Color=Color(red: 50/255, green: 50/255, blue: 50/255)
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors:
                    [
                        Color.gray,
                        Color(.systemGray2),
                        Color(.systemGray3),
                        Color(.systemGray4),
                        Color(.systemGray5),
                        Color(.systemGray6)
                    ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(.all)
            
            List {
                ForEach(self.task) {task in
                    HStack {
                        Rectangle()
                            .foregroundStyle(task.color)
                            .frame(width: 50)
                        
                        VStack(alignment: .leading) {
                            Text(task.title)
                            
                            Text(task.content)
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparatorTint(.black)
            }
            .scrollContentBackground(.hidden)
            
            if(!self.show) {
                ZStack {
                    Circle()
                        .matchedGeometryEffect(id: "add", in: self.namespace)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(.white)
                        .offset(x: -25, y: -25)
                        .matchedGeometryEffect(id: "add", in: self.namespace)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.title=""
                        self.content=""
                    }
                    withAnimation(.spring(dampingFraction: 0.75)) {
                        self.show.toggle()
                    }
                    withAnimation(.smooth(duration: 0.1).delay(0.3)) {
                        self.showView.toggle()
                    }
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .matchedGeometryEffect(id: "add", in: self.namespace)
                        .frame(width: 350, height: 300)
                        .foregroundStyle(self.buttonBackground)
                    
                    if(self.showView) {
                        VStack(spacing: 20) {
                            HStack {
                                TextField("Title...", text: self.$title)
                                    .padding(.leading, 5)
                                    .frame(width: 200, height: 40)
                                    .background(.white, in: .rect(cornerRadius: 10, style: .continuous))
                                
                                Spacer()
                                
                                Button {
                                    withAnimation(.smooth(duration: 0.1)) {
                                        self.showView.toggle()
                                    }
                                    withAnimation(.spring(dampingFraction: 0.75)) {
                                        self.show.toggle()
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.black)
                                        .frame(width: 40, height: 40)
                                        .background(.white, in: .circle)
                                }
                            }
                            
                            TextEditor(text: self.$content)
                                .frame(height: 80)
                                .overlay(alignment: .topLeading) {
                                    Text(self.title.isEmpty ? "Please write the title first":"Content...")
                                        .foregroundStyle(.gray.opacity(0.5))
                                        .padding([.top, .leading], 8)
                                        .opacity(self.content.isEmpty ? 1:0)
                                        .animation(.smooth, value: self.title)
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .disabled(self.title.isEmpty)
                            
                            HStack(spacing: 10) {
                                ForEach(self.color, id: \.self) {color in
                                    Circle()
                                        .frame(width: 35, height: 35)
                                        .foregroundStyle(color)
                                        .overlay {
                                            Circle()
                                                .stroke(lineWidth: 2)
                                                .foregroundStyle(.white)
                                                .opacity(self.selectColor==color ? 1:0)
                                        }
                                        .onTapGesture {
                                            withAnimation(.easeInOut) {
                                                self.selectColor=color
                                            }
                                        }
                                }
                            }
                            
                            Button {
                                withAnimation(.smooth(duration: 0.1)) {
                                    self.showView.toggle()
                                }
                                withAnimation(.spring(dampingFraction: 0.75)) {
                                    self.show.toggle()
                                }
                                withAnimation(.easeInOut) {
                                    self.task.append(Tasks(title: self.title, content: self.content, color: self.selectColor))
                                    self.title=""
                                    self.content=""
                                }
                            } label: {
                                Text("Save")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .background(.black, in: .rect(cornerRadius: 10))
                            }
                            .disabled(self.title.isEmpty || self.content.isEmpty)
                        }
                        .padding()
                        .frame(width: 350, height: 300)
                    }
                }
                .scaleEffect(self.scale)
                .offset(self.newOffset)
                .gesture(
                    DragGesture()
                        .onChanged {gesture in
                            self.newOffset=CGSize(
                                width: self.oldOffset.width+gesture.translation.width,
                                height: self.oldOffset.height+gesture.translation.height
                            )
                            
                            let distance: Double=sqrt(pow(gesture.translation.width, 2)+pow(gesture.translation.height, 2))
                            self.scale=max(1-distance/1000, 0.5)
                        }
                        .onEnded {gesture in
                            let distance: Double=sqrt(pow(gesture.translation.width, 2)+pow(gesture.translation.height, 2))
                            
                            if(distance>100) {
                                withAnimation(.smooth(duration: 0.1)) {
                                    self.showView.toggle()
                                }
                                withAnimation(.spring(dampingFraction: 0.75)) {
                                    self.show.toggle()
                                }
                            } else {
                                withAnimation(.smooth) {
                                    self.oldOffset=CGSize.zero
                                    self.newOffset=CGSize.zero
                                }
                            }
                            
                            withAnimation(.smooth){
                                self.scale=1
                            }
                        }
                )
            }
        }
        .onChange(of: self.show) {
            self.oldOffset=CGSize.zero
            self.newOffset=CGSize.zero
        }
    }
}
