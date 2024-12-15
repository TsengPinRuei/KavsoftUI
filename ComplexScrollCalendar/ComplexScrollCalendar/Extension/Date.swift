//
//  Date.swift
//  ComplexScrollCalendar
//
//  Created by 曾品瑞 on 2023/11/18.
//

import SwiftUI

extension Date {
    static var currentMonth: Date {
        let calendar: Calendar=Calendar.current
        
        guard let current: Date=calendar.date(from: Calendar.current.dateComponents([.month, .year], from: .now)) else { return .now }
        return current
    }
}
