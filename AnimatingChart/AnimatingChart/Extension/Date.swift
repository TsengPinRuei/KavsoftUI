//
//  Date.swift
//  AnimatingChart
//
//  Created by 曾品瑞 on 2024/4/8.
//

import SwiftUI

extension Date {
    static func create(_ day: Int, _ month: Int, _ year: Int) -> Date {
        let calendar: Calendar=Calendar.current
        var component: DateComponents=DateComponents()
        component.day=day
        component.month=month
        component.year=year
        return calendar.date(from: component) ?? Date()
    }
}
