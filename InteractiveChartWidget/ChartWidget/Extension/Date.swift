//
//  Date.swift
//  ChartWidgetExtension
//
//  Created by 曾品瑞 on 2023/12/3.
//

import SwiftUI

extension Date {
    static func day(_ value: Int) -> Date {
        let calendar: Calendar=Calendar.current
        return calendar.date(byAdding: .day, value: value, to: .now) ?? .now
    }
}
