//
//  UniversalView.swift
//  AppWideOverlay
//
//  Created by 曾品瑞 on 2024/10/22.
//

import SwiftUI

struct UniversalView: View {
    @Environment(Universal.self) private var universal
    
    var body: some View {
        ZStack {
            ForEach(self.universal.view) {
                $0.view
            }
        }
    }
}

#Preview {
    UniversalView()
}
