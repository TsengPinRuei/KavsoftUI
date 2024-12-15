//
//  HomeView.swift
//  ComplexScrollCalendar
//
//  Created by 曾品瑞 on 2023/11/18.
//

import SwiftUI

struct HomeView: View {
    @State private var date: Date=Date.now
    @State private var month: Date=Date.currentMonth
    
    private var currentMonth: String { return self.format("MMMM") }
    private var currentYear: String { return self.format("dd YYYY") }
    private var calendarHeight: CGFloat { return self.titleHeight+self.weekHeight+self.gridHeight+self.safeArea.top+self.edgePadding(edge: .top)+self.edgePadding(edge: .bottom) }
    private var gridHeight: CGFloat { return CGFloat(self.monthDay.count/7)*50 }
    private var progress: CGFloat {
        let calendar=Calendar.current
        
        if let index=self.monthDay.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: self.date) }) {
            return CGFloat(index/7).rounded()
        }
        return 1.0
    }
    private var titleHeight: CGFloat { return 75 }
    private var weekHeight: CGFloat { return 30 }
    private var monthDay: [Day] { return self.extractDate(self.month) }
    var safeArea: EdgeInsets
    
    @ViewBuilder
    private func CalendarView() -> some View {
        GeometryReader {
            let size=$0.size
            let maxHeight: CGFloat=size.height-(self.titleHeight+self.weekHeight+self.safeArea.top+self.edgePadding(edge: .top)+self.edgePadding(edge: .bottom))
            let minY: CGFloat=$0.frame(in: .scrollView(axis: .vertical)).minY
            let progress: CGFloat=max(min(-minY/maxHeight, 1), 0)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(self.currentMonth)
                    .font(.system(size: 35-10*progress))
                    .offset(y: -50*progress)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .overlay(alignment: .topLeading) {
                        GeometryReader {
                            let size: CGSize=$0.size
                            
                            Text(self.currentYear)
                                .font(.system(size: 25-10*progress))
                                .offset(x: (size.width+5)*progress, y: progress*3)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .topTrailing) {
                        HStack(spacing: 20) {
                            Button("", systemImage: "chevron.left") {
                                self.updateMonth(false)
                            }
                            .contentShape(.rect)
                            
                            Button("", systemImage: "chevron.right") {
                                self.updateMonth(true)
                            }
                            .contentShape(.rect)
                        }
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .offset(x: 150*progress)
                    }
                    .frame(height: self.titleHeight)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(Calendar.current.weekdaySymbols, id: \.self) {symbol in
                            Text(symbol.prefix(3))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: self.weekHeight, alignment: .bottom)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0) {
                        ForEach(self.monthDay) {day in
                            Text(day.symbol)
                                .foregroundStyle(day.ignore ? .secondary:.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .overlay(alignment: .bottom) {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 5, height: 5)
                                        .opacity(Calendar.current.isDate(day.date, inSameDayAs: self.date) ? 1:0)
                                        .offset(y: progress * -3)
                                }
                                .contentShape(.rect)
                                .onTapGesture {
                                    self.date=day.date
                                }
                        }
                    }
                    .frame(height: self.gridHeight-((self.gridHeight-50)*progress), alignment: .top)
                    .offset(y: self.progress * -50*progress)
                    .contentShape(.rect)
                    .clipped()
                }
                .offset(y: progress * -50)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, self.edgePadding(edge: .horizontal))
            .padding(.top, self.edgePadding(edge: .top))
            .padding(.top, self.safeArea.top)
            .padding(.bottom, self.edgePadding(edge: .bottom))
            .frame(maxHeight: .infinity)
            .frame(height: size.height-(maxHeight*progress), alignment: .top)
            .background(.black.gradient)
            .clipped()
            .contentShape(.rect)
            .offset(y: -minY)
        }
        .frame(height: self.calendarHeight)
        .zIndex(1)
    }
    @ViewBuilder
    private func DetailView() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray.gradient)
            .frame(height: 70)
            .overlay(alignment: .leading) {
                HStack(spacing: 10) {
                    Circle().frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 5)
                        
                        RoundedRectangle(cornerRadius: 10).frame(width: 70, height: 5)
                    }
                }
                .foregroundStyle(.ultraThinMaterial)
                .padding()
            }
    }
    
    private func format(_ format: String) -> String {
        let formatter: DateFormatter=DateFormatter()
        formatter.dateFormat=format
        return formatter.string(from: self.month)
    }
    private func edgePadding(edge: Edge.Set) -> CGFloat {
        if(edge == .top || edge == .horizontal) {
            return 15
        } else if(edge == .bottom) {
            return 5
        } else {
            return 0
        }
    }
    private func updateMonth(_ increment: Bool) {
        let calendar: Calendar=Calendar.current
        guard let month: Date=calendar.date(byAdding: .month, value: increment ? 1:-1, to: self.month) else { return }
        guard let date: Date=calendar.date(byAdding: .month, value: increment ? 1:-1, to: self.date) else { return }
        self.month=month
        self.date=date
    }
    
    var body: some View {
        let height: CGFloat=self.calendarHeight-(self.titleHeight+self.weekHeight+self.safeArea.top+self.edgePadding(edge: .top)+self.edgePadding(edge: .bottom))
        
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                self.CalendarView()
                
                VStack(spacing: 20) {
                    ForEach(0..<20, id: \.self) {_ in
                        self.DetailView()
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemGray5).gradient)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(CustomScrollBehavior(height: height))
    }
}
