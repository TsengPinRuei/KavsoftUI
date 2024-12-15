//
//  Date.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/11.
//

import SwiftUI

extension Date {
    struct WeekDay: Identifiable {
        var id: UUID=UUID()
        var date: Date
    }
    
    var isPast: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending
    }
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame
    }
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    static func updateHour(_ value: Int) -> Date {
        let calendar: Calendar=Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: Date()) ?? Date()
    }
    
    func createPreviousWeek() -> [WeekDay] {
        let calendar: Calendar=Calendar.current
        let start: Date=calendar.startOfDay(for: self)
        
        guard let next=calendar.date(byAdding: .day, value: -7, to: start) else { return [] }
        return self.getWeek(next)
    }
    func createNextWeek() -> [WeekDay] {
        let calendar: Calendar=Calendar.current
        let start: Date=calendar.startOfDay(for: self)
        
        guard let next=calendar.date(byAdding: .day, value: 1, to: start) else { return [] }
        return self.getWeek(next)
    }
    func format(_ format: String) -> String {
        let formatter: DateFormatter=DateFormatter()
        formatter.dateFormat=format
        return formatter.string(from: self)
    }
    func getWeek(_ date: Date=Date()) -> [WeekDay] {
        let calendar: Calendar=Calendar.current
        let startDate: Date=calendar.startOfDay(for: date)
        var week: [WeekDay]=[]
        let weekDate: DateInterval?=calendar.dateInterval(of: .weekOfMonth, for: startDate)
        
        guard weekDate?.start != nil else { return [] }
        for i in 0..<7 {
            if let weekDay=calendar.date(byAdding: .day, value: i, to: startDate) {
                week.append(WeekDay(date: weekDay))
            }
        }
        return week
    }
}
