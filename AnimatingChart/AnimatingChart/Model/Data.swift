//
//  Data.swift
//  AnimatingChart
//
//  Created by 曾品瑞 on 2024/4/8.
//

import SwiftUI

struct Data: Identifiable {
    var id: UUID=UUID()
    var date: Date
    var value: Double
    var animate: Bool=false
    var month: String {
        let format: DateFormatter=DateFormatter()
        format.dateFormat="MMM"
        return format.string(from: self.date)
    }
    var monthNumber: Int {
        let format: DateFormatter=DateFormatter()
        format.dateFormat="MM"
        return Int(format.string(from: self.date)) ?? 0
    }
}

var data: [Data]=[
    Data(date: Date.create(27, 9, 2001), value: 2021),
    Data(date: Date.create(6, 11, 2003), value: 1102),
    Data(date: Date.create(26, 8, 2007), value: 1091),
    Data(date: Date.create(12, 11, 2004), value: 4054),
    Data(date: Date.create(13, 8, 2002), value: 6135),
    Data(date: Date.create(5, 6, 2002), value: 5605)
]
