//
//  NoteView.swift
//  NoteApp
//
//  Created by 曾品瑞 on 2024/10/10.
//

import SwiftUI

struct NoteView: View {
    @Bindable var note: Note
    
    @State private var layer: Bool=false
    
    var size: CGSize
    var title: CGSize
    var animation: Namespace.ID
    var area: UIEdgeInsets {
        if let area=(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return area
        } else {
            return .zero
        }
    }
    
    @ViewBuilder
    private func ContentView() -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            VStack(alignment: .leading, spacing: 20) {
                TextField("Title", text: self.$note.title, axis: .vertical)
                    .font(.title)
                    .lineLimit(2)
                
                TextEditor(text: self.$note.content)
                    .font(.title3)
                    .overlay(alignment: .topLeading) {
                        if(self.note.content.isEmpty) {
                            Text("Type Something...")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                                .offset(x: 10, y: 10)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
            }
            .foregroundStyle(.black)
            .padding()
            .padding(.top, self.area.top)
            .frame(width: self.size.width, height: self.size.height)
            .frame(width: size.width, height: size.height, alignment: .topLeading)
        }
        .blur(radius: self.layer ? 0:100)
        .opacity(self.layer ? 1:0)
    }
    
    var body: some View {
        Rectangle()
            .fill(note.color.gradient)
            .overlay(alignment: .topLeading) {
                TitleView(size: self.size, note: self.note)
                    .blur(radius: self.layer ? 100:0)
                    .opacity(self.layer ? 0:1)
            }
            .overlay {
                self.ContentView()
            }
            .clipShape(.rect(cornerRadius: self.layer ? 0:10))
            .matchedGeometryEffect(id: note.id, in: self.animation)
            .transition(.offset(y: 1))
            .allowsHitTesting(note.hit)
            .onChange(of: self.note.hit, initial: true) {(_, new) in
                withAnimation(self.noteAnimation) {
                    self.layer=new
                }
            }
    }
}
