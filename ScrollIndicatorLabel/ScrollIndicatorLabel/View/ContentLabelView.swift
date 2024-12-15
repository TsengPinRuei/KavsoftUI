//
//  ContentLabelView.swift
//  ScrollIndicatorLabel
//
//  Created by 曾品瑞 on 2023/12/18.
//

import SwiftUI

struct ContentLabelView: View {
    @State private var hide: Bool=true
    @State private var height: CGFloat=0
    @State private var indicator: CGFloat=0
    @State private var start: CGFloat=0
    @State private var timeOut: CGFloat=1
    @State private var current: Character=Character(value: "")
    @State private var character: [Character]=[]
    
    @ViewBuilder
    private func CharacterView(character: Character) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(character.value)
                .bold()
                .font(.largeTitle)
            
            ForEach(0..<5, id: \.self) {_ in
                HStack(spacing: 10) {
                    Circle()
                        .fill(character.color.gradient)
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(character.color.gradient)
                            .frame(height: 20)
                        
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(character.color.gradient)
                            .frame(height: 20)
                            .padding(.trailing, 100)
                    }
                }
            }
        }
        .offsetForNL {rect in
            if(self.character.indices.contains(character.index)) {
                self.character[character.index].rect=rect
            }
            
            if let last=self.character.last(where: {character in
                character.rect.minY<0
            }), last.id != self.current.id {
                self.current=last
            }
        }
        .padding()
    }
    
    private func getCharacter() -> [Character] {
        let alphabet: String="ABCDEFGHIJKLMNOPQRSTUVWXYZ."
        let color: [Color]=[.red, .orange, .yellow, .green, .blue, .purple]
        var character: [Character]=[]
        
        character=alphabet.compactMap {character -> Character? in
            return Character(value: String(character))
        }
        
        for i in character.indices {
            character[i].index=i
            character[i].color=color.randomElement()!
        }
        
        return character
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            ScrollViewReader {reader in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(self.character) {character in
                            self.CharacterView(character: character).id(character.index)
                        }
                    }
                    .padding(.top)
                    .padding(.trailing, 20)
                    .offsetForNL {rect in
                        if(self.hide && rect.minY<0) {
                            self.timeOut=0
                            self.hide=false
                        }
                        
                        let viewHeight: CGFloat=size.height+self.start/2
                        let scrollHeight: CGFloat=viewHeight/rect.height*viewHeight
                        let progress: CGFloat=rect.minY/(rect.height-size.height)
                        
                        self.height=scrollHeight
                        self.indicator = -progress*(size.height-scrollHeight)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topTrailing) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 3, height: self.height)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "bubble.middle.bottom.fill")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(width: 50, height: 50)
                            .rotationEffect(Angle(degrees: -90))
                            .overlay {
                                Text(self.current.value)
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .offset(x: -5)
                            }
                            .environment(\.colorScheme, .dark)
                            .opacity((self.hide || self.current.value.isEmpty) ? 0:1)
                    }
                    .padding(.trailing, 5)
                    .offset(y: self.indicator)
            }
            .coordinateSpace(.named("SCROLLER"))
        }
        .navigationTitle("Alphabet Character")
        .toolbarTitleDisplayMode(.inline)
        .offsetForNL {rect in
            if(self.start != rect.minY) {
                self.start=rect.minY
            }
        }
        .onAppear {
            self.character=self.getCharacter()
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .default).autoconnect()) {_ in
            if(self.timeOut<1) {
                self.timeOut+=0.01
            } else if(!self.hide) {
                withAnimation(.smooth) {
                    self.hide=true
                }
            }
        }
    }
}
