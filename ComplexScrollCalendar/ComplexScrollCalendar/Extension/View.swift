//
//  View.swift
//  ComplexScrollCalendar
//
//  Created by 曾品瑞 on 2023/11/18.
//

import SwiftUI

extension View {
    func extractDate(_ month: Date) -> [Day] {
        let calendar: Calendar=Calendar.current
        let format: DateFormatter=DateFormatter()
        var day: [Day]=[]
        
        guard let range=calendar
            .range(of: .day, in: .month, for: month)?
            .compactMap({value -> Date? in
                return calendar.date(byAdding: .day, value: value-1, to: month)}
            ) else { return day }
        
        let first: Int=calendar.component(.weekday, from: range.first!)
        
        for i in Array(0..<first-1).reversed() {
            guard let date=calendar.date(byAdding: .day, value: -i-1, to: range.first!) else { return day }
            let symbol=format.string(from: date)
            day.append(Day(symbol: symbol, date: date, ignore: true))
        }
        
        format.dateFormat="dd"
        range.forEach {date in
            let symbol: String=format.string(from: date)
            day.append(Day(symbol: symbol, date: date))
        }
        
        let last: Int=7-calendar.component(.weekday, from: range.last!)
        
        if(last>0) {
            for i in 0..<last {
                guard let date=calendar.date(byAdding: .day, value: i+1, to: range.last!) else { return day }
                let symbol=format.string(from: date)
                day.append(Day(symbol: symbol, date: date, ignore: true))
            }
        }
        
        return day
    }
}
