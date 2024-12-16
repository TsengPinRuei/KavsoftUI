//
//  HackTextView.swift
//  HackTextEffect
//
//  Created by 曾品瑞 on 2024/5/20.
//

import SwiftUI

struct HackTextView: View {
    @State private var animateText: String=""
    @State private var id: String=UUID().uuidString
    
    var text: String
    var trigger: Bool
    var transition: ContentTransition
    var duration: CGFloat
    var speed: CGFloat
    
    private let character: [Character]={
        let character: String="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+-*/!?@#$%^&*()"
        return Array(character)
    }()
    
    private func animate() {
        let current: String=self.id
        
        for i in self.text.indices {
            let delay: CGFloat=CGFloat.random(in: 0...self.duration)
            var duration: CGFloat=0
            let timer: Timer=Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) {timer in
                if(current != self.id) {
                    timer.invalidate()
                } else {
                    duration+=self.speed
                    if(duration>=delay) {
                        if(self.text.indices.contains(i)) {
                            let current: Character=self.text[i]
                            self.replace(at: i, character: current)
                        }
                        
                        timer.invalidate()
                    } else {
                        guard let random=self.character.randomElement() else { return }
                        self.replace(at: i, character: random)
                    }
                }
            }
            timer.fire()
        }
    }
    private func random() {
        self.animateText=self.text
        for i in self.animateText.indices {
            guard let random=self.character.randomElement() else { return }
            self.replace(at: i, character: random)
        }
    }
    private func replace(at index: String.Index, character: Character) {
        guard self.animateText.indices.contains(index) else { return }
        
        let indexCharacter: String=String(self.animateText[index])
        
        if(indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
            self.animateText.replaceSubrange(index...index, with: String(character))
        }
    }
    
    var body: some View {
        Text(self.animateText)
            .fontDesign(.monospaced)
            .truncationMode(.tail)
            .contentTransition(self.transition)
            .animation(.easeInOut(duration: 0.1), value: self.animateText)
            .onAppear {
                guard self.animateText.isEmpty else { return }
                self.random()
                self.animate()
            }
            .onChange(of: self.trigger) {
                self.animate()
            }
            .onChange(of: self.text) {
                self.animateText=self.text
                self.id=UUID().uuidString
                self.random()
                self.animate()
            }
    }
}
