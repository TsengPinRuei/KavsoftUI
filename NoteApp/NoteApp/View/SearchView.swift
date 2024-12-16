//
//  SearchView.swift
//  NoteApp
//
//  Created by 曾品瑞 on 2024/10/12.
//

import SwiftUI
import SwiftData

struct SearchView<Content: View>: View {
    @Query var note: [Note]
    
    var content: ([Note]) -> Content
    
    init(text: String, @ViewBuilder content: @escaping ([Note]) -> Content) {
        self.content=content
        
        let empty: Bool=text.isEmpty
        let predicate: Predicate=#Predicate<Note> {
            return empty || $0.title.localizedStandardContains(text)
        }
        
        self._note = .init(filter: predicate, sort: [.init(\.date, order: .reverse)], animation: .snappy)
    }
    var body: some View {
        self.content(self.note).animation(self.noteAnimation, value: self.note)
    }
}
