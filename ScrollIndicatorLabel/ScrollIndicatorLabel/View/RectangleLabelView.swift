//
//  RectangleLabelView.swift
//  ScrollIndicatorLabel
//
//  Created by 曾品瑞 on 2023/12/16.
//

import SwiftUI

struct RectangleLabelView: View {
    @GestureState private var drag: Bool=false
    
    @State private var isDrag: Bool=false
    @State private var current: Int=0
    @State private var startY: CGFloat=0
    @State private var y: CGFloat=0
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
        .padding()
        .offsetForRL {rect in
            let minY: CGFloat=rect.minY
            let index: Int=character.index
            
            if(minY>20 && minY<self.startY && !self.isDrag) {
                self.updateElevate(index: index)
                withAnimation(.smooth(duration: 0.2)) {
                    self.y=self.character[index].rect.minY
                }
            }
        }
    }
    @ViewBuilder
    private func KnobView(character: Binding<Character>, rect: CGRect) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(.primary)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
                    .scaleEffect(self.drag ? 0.8:0.0001)
            }
            .scaleEffect(self.drag ? 1.5:1)
            .animation(.smooth(duration: 0.2), value: self.drag)
            .offset(y: self.y)
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating(self.$drag) {(_, out, _) in
                        out=true
                    }
                    .onChanged {value in
                        self.isDrag=true
                        
                        var translation: CGFloat=value.location.y-20
                        
                        translation=min(translation, rect.maxY-20)
                        translation=max(translation, rect.minY)
                        self.y=translation
                        self.elevateCharacter()
                    }
                    .onEnded {value in
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                            self.isDrag=false
                        }
                        
                        if(self.character.indices.contains(self.current)) {
                            withAnimation(.smooth(duration: 0.2)) {
                                self.y=self.character[self.current].rect.minY
                            }
                        }
                    }
            )
    }
    @ViewBuilder
    private func ScrollerView() -> some View {
        GeometryReader {reader in
            let rect: CGRect=reader.frame(in: .named("SCROLLER"))
            
            VStack(spacing: 0) {
                ForEach(self.$character) {$character in
                    HStack(spacing: 20) {
                        GeometryReader {reader in
                            let origin: CGRect=reader.frame(in: .named("SCROLLER"))
                            
                            Text(character.value)
                                .bold()
                                .font(.callout)
                                .foregroundStyle(character.current ? Color.primary:Color.gray)
                                .scaleEffect(character.current ? 2:1)
                                .contentTransition(.interpolate)
                                .frame(width: origin.size.width, height: origin.size.height, alignment: .trailing)
                                .overlay {
                                    Rectangle()
                                        .fill(character.current ? .clear:.gray)
                                        .frame(width: 20, height: 1)
                                        .offset(x: 40)
                                        .animation(.none, value: character.current)
                                }
                                .animation(.smooth(duration: 0.2), value: [character.offset])
                                .animation(.smooth(duration: 0.2), value: [character.current])
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                                        character.rect=origin
                                    }
                                }
                        }
                        .frame(width: 20)
                        
                        ZStack {
                            if(self.character.first?.id==character.id) {
                                self.KnobView(character: $character, rect: rect)
                            }
                        }
                        .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .frame(width: 50)
        .padding(.trailing)
        .coordinateSpace(name: "SCROLLER")
        .padding(.vertical)
    }
    
    private func elevateCharacter() {
        if let index=self.character.firstIndex(where: {character in
            character.rect.contains(CGPoint(x: 0, y: self.y))
        }) {
            self.updateElevate(index: index)
        }
    }
    private func getCharacter() -> [Character] {
        let alphabet: String="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
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
    private func updateCheck(index: Int, offset: CGFloat) -> Bool {
        if(self.character.indices.contains(index)) {
            self.character[index].offset=offset
            self.character[index].current=false
            return true
        } else {
            return false
        }
    }
    private func updateElevate(index: Int) {
        var indice: [Int]=[]
        
        self.character[index].offset = -40
        self.character[index].current=true
        self.current=index
        indice.append(index)
        
        let offset: [CGFloat]=[-30, -20, -10]
        for i in offset.indices {
            let positive: Int=index+(i+1)
            let negative: Int=index-(i+1)
            
            if(self.updateCheck(index: positive, offset: offset[i])) {
                indice.append(positive)
            }
            if(self.updateCheck(index: negative, offset: offset[i])) {
                indice.append(negative)
            }
        }
        
        for i in self.character.indices {
            if(!indice.contains(i)) {
                self.character[i].offset=0
                self.character[i].current=false
            }
        }
    }
    
    var body: some View {
        ScrollViewReader {reader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(self.character) {character in
                        self.CharacterView(character: character).id(character.index)
                    }
                }
                .padding(.top)
                .padding(.trailing, 100)
            }
            .onChange(of: self.current) {
                if(self.isDrag) {
                    withAnimation(.smooth(duration: 0.2)) {
                        reader.scrollTo(self.current, anchor: .top)
                    }
                }
            }
        }
        .navigationTitle("Alphabet Character")
        .toolbarTitleDisplayMode(.inline)
        .offsetForRL {rect in
            if(rect.minY != self.startY) {
                self.startY=rect.minY
            }
        }
        .overlay(alignment: .trailing) {
            self.ScrollerView().padding(.top)
        }
        .onAppear {
            self.character=self.getCharacter()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                self.elevateCharacter()
            }
        }
    }
}
