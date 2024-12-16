//
//  LimitTextFieldView.swift
//  LimitTextField
//
//  Created by 曾品瑞 on 2024/4/3.
//

import SwiftUI

struct LimitTextFieldView: View {
    struct Border {
        var show: Bool=false
        var radius: CGFloat
        var width: CGFloat
    }
    struct Configuration {
        var limit: Int
        var tint: Color=Color.primary
        var resize: Bool
        var excess: Bool
        var border: Border
        var progress: Progress
    }
    struct Progress {
        var ring: Bool
        var text: Bool
        var alignment: HorizontalAlignment=HorizontalAlignment.trailing
    }
    
    var configuration: Configuration
    var hint: String
    
    @Binding var text: String
    
    @FocusState private var showKeyboard: Bool
    
    var progress: CGFloat { return max(min(CGFloat(self.text.count)/CGFloat(self.configuration.limit), 1), 0) }
    var progressTint: Color { return self.progress<0.5 ? self.configuration.tint:(self.progress==1 ? .red:.orange) }
    
    var body: some View {
        VStack(alignment: self.configuration.progress.alignment, spacing: 10) {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: self.configuration.border.radius)
                    .fill(.clear)
                    .frame(height: self.configuration.resize ? 0:nil)
                    .contentShape(.rect(cornerRadius: self.configuration.border.radius))
                    .onTapGesture {
                        self.showKeyboard=true
                    }
                
                TextField(self.hint, text: self.$text, axis: .vertical)
                    .focused(self.$showKeyboard)
                    .onChange(of: self.configuration.excess) {(_, new) in
                        if(!new) {
                            self.text=String(self.text.prefix(self.configuration.limit))
                        }
                    }
                    .onChange(of: self.text) {
                        guard !self.configuration.excess else { return }
                        self.text=String(self.text.prefix(self.configuration.limit))
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: self.configuration.border.radius)
                    .stroke(self.progressTint.gradient, lineWidth: self.configuration.border.width)
            }
            
            HStack(alignment: .top, spacing: 10) {
                if(self.configuration.progress.ring) {
                    ZStack {
                        Circle().stroke(.ultraThinMaterial, lineWidth: 5)
                        
                        Circle()
                            .trim(from: 0, to: self.progress)
                            .stroke(self.progressTint.gradient, lineWidth: 5)
                            .rotationEffect(Angle(degrees: -90))
                    }
                    .frame(width: 20, height: 20)
                }
                
                if(self.configuration.progress.text) {
                    Text("\(self.text.count) / \(self.configuration.limit)").foregroundStyle(self.progressTint.gradient)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}
