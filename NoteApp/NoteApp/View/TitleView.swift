//
//  TitleView.swift
//  NoteApp
//
//  Created by 曾品瑞 on 2024/10/12.
//

import SwiftUI

struct TitleView: View {
    var size: CGSize
    var note: Note
    
    var body: some View {
        Text(self.note.title)
            .font(.title3)
            .fontWeight(.medium)
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .frame(width: self.size.width, height: self.size.height)
    }
}
