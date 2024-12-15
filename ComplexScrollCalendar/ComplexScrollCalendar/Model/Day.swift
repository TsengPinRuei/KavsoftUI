//
//  Day.swift
//  ComplexScrollCalendar
//
//  Created by 曾品瑞 on 2023/11/18.
//

import SwiftUI

struct Day: Identifiable {
    var id: UUID=UUID()
    var symbol: String
    var date: Date
    var ignore: Bool=false
}
