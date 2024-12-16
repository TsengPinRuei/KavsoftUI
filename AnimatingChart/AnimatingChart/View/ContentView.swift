//
//  ContentView.swift
//  AnimatingChart
//
//  Created by 曾品瑞 on 2024/4/8.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var animate: Bool=false
    @State private var append: Bool=false
    @State private var select: Int=0
    @State private var data: [Data]=Array(AnimatingChart.data)
    
    var maxY: Double {
        var max: Double=0
        var value: [Double]=Array(repeating: 0, count: 12)
        
        for i in self.data {
            value[i.monthNumber-1]+=i.value
        }
        for i in value {
            max=max<i ? i:max
        }
        
        return max.truncatingRemainder(dividingBy: 1000)==0 ? max:(max/1000+1)*1000
    }
    
    private func animateChart() {
        guard !self.animate else { return }
        self.animate=true
        self.$data.enumerated().forEach {(index, data) in
            let delay: Double=Double(index)*0.05
            
            DispatchQueue.main.asyncAfter(deadline: .now()+delay) {
                withAnimation(.smooth) {
                    data.wrappedValue.animate=true
                }
            }
        }
    }
    private func resetAnimation() {
        self.$data.forEach {data in
            data.wrappedValue.animate=false
        }
        
        self.animate=false
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Chart") {
                    Picker("", selection: self.$select) {
                        Text("Bar").tag(0)
                        
                        Text("Pie").tag(1)
                    }
                    .pickerStyle(.segmented)
                }
                .headerProminence(.increased)
                
                Section("Demonstration") {
                    Chart {
                        ForEach(self.data) {data in
                            if(self.select==0) {
                                BarMark(
                                    x: .value("Month", data.month),
                                    y: .value("Data", data.animate ? data.value:0)
                                )
                                .foregroundStyle(by: .value("Month", data.month))
                                .opacity(data.animate ? 1:0)
                            } else if(self.select==1) {
                                SectorMark(
                                    angle: .value("Data", data.animate ? data.value:0)
                                )
                                .foregroundStyle(by: .value("Month", data.month))
                                .opacity(data.animate ? 1:0)
                            }
                        }
                    }
                    .chartYScale(domain: 0...self.maxY)
                    .frame(height: 300)
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Animate Chart")
            .onAppear(perform: self.animateChart)
            .onChange(of: self.select) {
                self.resetAnimation()
                self.animateChart()
            }
            .onChange(of: self.append) {
                self.resetAnimation()
                self.animateChart()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Append") {
                        withAnimation(.smooth) {
                            self.data.append(
                                contentsOf: [
                                    Data(
                                        date:
                                            Date.create(
                                                Int.random(in: 1...25),
                                                Int.random(in: 1...12),
                                                Int.random(in: 2000...2024)
                                            ),
                                        value: Double.random(in: 1000...10000)
                                    )
                                ]
                            )
                        }
                        self.append.toggle()
                    }
                    .disabled(self.select==1)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        withAnimation(.smooth) {
                            self.data=Array(AnimatingChart.data)
                        }
                        self.resetAnimation()
                        self.animateChart()
                    }
                    .tint(.red)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
