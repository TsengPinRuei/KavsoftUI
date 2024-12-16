//
//  ContentView.swift
//  TextParticle
//
//  Created by Justin on 11/18/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    //MARK: Property
    @State private var show: Bool=false
    @State private var tint: Int=0
    @State private var amount: Double=1000
    @State private var frame: Double=3
    @State private var max: Double=400
    @State private var power: Double=0.0001
    @State private var size: Double=200
    @State private var text : String="❤️"
    
    private func setTint(index: Int) -> Color {
        switch(index) {
        case 0: return .white
        case 1: return .red
        case 2: return .orange
        case 3: return .yellow
        case 4: return .green
        case 5: return .blue
        case 6: return .purple
        default: return .white
        }
    }
    
    var body: some View {
        ZStack {
            //MARK: ParticleView
            ParticleView(
                tint: self.setTint(index: self.tint),
                amount: self.amount,
                frame: self.frame,
                textSize: self.size,
                text: self.text,
                power: self.power
            )
            .animation(.snappy, value: self.tint)
            .animation(.snappy, value: self.amount)
            .animation(.snappy, value: self.frame)
            .animation(.snappy, value: self.size)
            .animation(.snappy, value: self.text)
            .animation(.snappy, value: self.power)
            .ignoresSafeArea(.all)
            
            //MARK: Button
            HStack {
                HStack {
                    Image(
                        systemName: "dot.radiowaves.left.and.right",
                        variableValue: self.power*10000
                    )
                    
                    Button(self.power==0.0001 ? "STRONG":"WEAK") {
                        withAnimation(.snappy) {
                            self.power=self.power==0.0001 ? 0.00005:0.0001
                        }
                    }
                    .font(.title3)
                    .contentTransition(.numericText())
                }
                
                Spacer(minLength: 0)
                
                Button("", systemImage: "gearshape.fill") {
                    self.show.toggle()
                }
            }
            .bold()
            .font(.title)
            .tint(.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
        }
        //MARK: Sheet
        .sheet(isPresented: self.$show) {
            NavigationStack {
                List {
                    //MARK: Text
                    Section("Text") {
                        TextField("What do you want to display ?", text: self.$text)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .submitLabel(.done)
                            .onSubmit {
                                if(self.text.isEmpty) {
                                    self.text="❤️"
                                }
                                
                                if(self.size>self.max) {
                                    self.size=self.max
                                }
                            }
                        
                        HStack {
                            Text("Size")
                            
                            Spacer(minLength: 0)
                            
                            HStack {
                                Text("\(Int(self.size))")
                                    .contentTransition(.numericText(value: self.size))
                                    .animation(.smooth, value: self.size)
                                
                                Stepper("", value: self.$size, in: 50...self.max, step: 25)
                                    .onChange(of: self.text) {
                                        let length: Int=self.text.count
                                        
                                        if(length==1) {
                                            self.max=400
                                        } else if(length==2) {
                                            self.max=200
                                        } else if(length==3) {
                                            self.max=150
                                        } else {
                                            self.max=100
                                        }
                                    }
                            }
                            .frame(width: 150)
                        }
                    }
                    .headerProminence(.increased)
                    
                    //MARK: Particle
                    Section("Particle") {
                        HStack {
                            Text("Amount")
                            
                            Spacer(minLength: 0)
                            
                            HStack {
                                Text("\(Int(self.amount))")
                                    .contentTransition(.numericText(value: self.amount))
                                    .animation(.smooth, value: self.amount)
                                
                                Stepper("", value: self.$amount, in: 500...5000, step: 500)
                            }
                            .frame(width: 150)
                        }
                        
                        HStack {
                            Text("Size")
                            
                            Spacer(minLength: 0)
                            
                            HStack {
                                Text("\(Int(self.frame))")
                                    .contentTransition(.numericText(value: self.frame))
                                    .animation(.smooth, value: self.frame)
                                
                                Stepper("", value: self.$frame, in: 1...5)
                            }
                            .frame(width: 120)
                        }
                        
                        Picker("Color", selection: self.$tint) {
                            let color: [Color]=[.white, .red, .orange, .yellow, .green, .blue, .purple]
                            
                            ForEach(color.indices, id: \.self) { index in
                                Text(color[index].description.capitalized).tag(index)
                            }
                        }
                    }
                    .headerProminence(.increased)
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .toolbarTitleDisplayMode(.inline)
                .navigationTitle("Particle Setting")
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .presentationBackground(.ultraThinMaterial)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
