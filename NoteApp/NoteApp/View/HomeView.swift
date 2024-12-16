//
//  HomeView.swift
//  NoteApp
//
//  Created by 曾品瑞 on 2024/10/10.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    @FocusState private var keyboard: Bool
    
    @Namespace private var animation
    
    @State private var animate: Bool=false
    @State private var title: CGSize=CGSize.zero
    @State private var text: String=""
    @State private var currentN: Note?
    @State private var deleteN: Note?
    
    @ViewBuilder
    private func BottomView() -> some View {
        HStack(spacing: 20) {
            if(self.currentN != nil && !self.keyboard && self.text.isEmpty) {
                Button {
                    self.currentN?.hit=false
                    if let currentN=self.currentN, currentN.title.isEmpty && currentN.content.isEmpty {
                        self.deleteN=currentN
                    }
                    
                    withAnimation(self.noteAnimation.logicallyComplete(after: 1), completionCriteria: .logicallyComplete) {
                        self.animate=false
                        self.currentN=nil
                    } completion: {
                        self.delete()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .foregroundStyle(Color.primary)
                        .contentShape(.rect)
                }
                .transition(.blurReplace)
            }
            
            Spacer(minLength: 0)
            
            Group {
                ZStack {
                    if(self.keyboard) {
                        Button("Done") {
                            self.keyboard=false
                        }
                        .font(.title3)
                        .foregroundStyle(Color.primary)
                        .transition(.blurReplace)
                    } else if(self.text.isEmpty) {
                        Button {
                            if(self.currentN==nil) {
                                self.create()
                            } else {
                                self.currentN?.hit=false
                                self.deleteN=self.currentN
                                withAnimation(self.noteAnimation.logicallyComplete(after: 1), completionCriteria: .logicallyComplete) {
                                    self.currentN=nil
                                    self.animate=false
                                } completion: {
                                    self.delete()
                                }
                            }
                        } label: {
                            Image(systemName: self.currentN==nil ? "plus.circle.fill":"trash.fill")
                                .foregroundStyle(self.currentN==nil ? Color.primary:Color.red)
                                .contentShape(.rect)
                                .contentTransition(.symbolEffect(.replace))
                        }
                        .transition(.blurReplace)
                    }
                }
            }
        }
        .font(.title2)
        .overlay {
            Text("Note")
                .font(.headline)
                .opacity(self.currentN != nil ? 0:1)
        }
        .overlay {
            if(self.currentN != nil && !self.keyboard) {
                self.PickerView().transition(.blurReplace)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, self.keyboard ? 10:16)
        .background(.bar)
        .animation(self.noteAnimation, value: self.currentN != nil)
        .animation(self.noteAnimation, value: self.keyboard)
    }
    @ViewBuilder
    private func PickerView() -> some View {
        let color: [Color]=[.red, .orange, .yellow, .green, .blue, .purple, .white]
        
        HStack(spacing: 10) {
            ForEach(color, id: \.self) {color in
                Button { } label: {
                    Circle()
                        .fill(color.gradient)
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(self.currentN?.color==color ? Color.primary:Color.gray))
                        .contentShape(.rect)
                        .onTapGesture {
                            withAnimation(self.noteAnimation){
                                self.currentN?.colorName=color.description
                            }
                        }
                }
            }
        }
    }
    @ViewBuilder
    private func PreView(_ note: Note) -> some View {
        ZStack {
            if(self.currentN?.id==note.id && self.animate) {
                RoundedRectangle(cornerRadius: 10).fill(.clear)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(note.color.gradient)
                    .overlay {
                        TitleView(size: self.title, note: note)
                    }
                    .matchedGeometryEffect(id: note.id, in: self.animation)
            }
        }
        .onGeometryChange(for: CGSize.self) { $0.size } action: {new in
            self.title=new
        }
    }
    @ViewBuilder
    private func SearchTextView() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
            
            TextField("Search For Title", text: self.$text).submitLabel(.search)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .overlay(alignment: .trailing) {
            if(!self.text.isEmpty) {
                Button("", systemImage: "x.circle.fill") {
                    withAnimation(.smooth) {
                        self.text=""
                    }
                }
                .tint(Color.primary)
                .contentShape(.rect)
                .transition(.opacity.animation(.easeInOut(duration: 0.1)))
            }
        }
        .background(.primary.opacity(0.1), in: .rect(cornerRadius: 10))
    }
    
    private func create() {
        let color: [String]=["red", "orange", "yellow", "green", "blue", "purple", "white"]
        let note: Note=Note(colorName: color.randomElement() ?? "", title: "", content: "")
        
        self.context.insert(note)
        Task {
            try? await Task.sleep(for: .seconds(0))
            self.currentN=note
            self.currentN?.hit=true
            withAnimation(self.noteAnimation) {
                self.animate=true
            }
        }
    }
    func delete() {
        if let deleteN=self.deleteN {
            self.context.delete(deleteN)
            try? self.context.save()
            self.deleteN=nil
        }
    }
    
    var body: some View {
        SearchView(text: self.text) {note in
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    self.SearchTextView()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(note) {note in
                            self.PreView(note).frame(height: 200)
                                .onTapGesture {
                                    guard self.currentN==nil else { return }
                                    
                                    self.keyboard=false
                                    self.currentN=note
                                    note.hit=true
                                    withAnimation(self.noteAnimation) {
                                        self.animate=true
                                    }
                                }
                        }
                    }
                }
            }
            .safeAreaPadding()
            .overlay {
                GeometryReader {
                    let size: CGSize=$0.size
                    
                    ForEach(note) {note in
                        if note.id==self.currentN?.id && self.animate {
                            NoteView(
                                note: note,
                                size: size,
                                title: self.title,
                                animation: self.animation
                            )
                            .ignoresSafeArea(.container, edges: .top)
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                self.BottomView()
            }
            .focused(self.$keyboard)
        }
    }
}

#Preview {
    ContentView()
}
