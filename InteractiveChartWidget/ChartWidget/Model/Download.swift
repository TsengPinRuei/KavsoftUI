//
//  Download.swift
//  ChartWidgetExtension
//
//  Created by 曾品瑞 on 2023/12/3.
//

import SwiftUI

struct Download: Identifiable, Equatable {
    var id: UUID=UUID()
    var date: Date
    var value: Int=Int.random(in: 50...500)
}

var appDownload1: [Download]=[
    Download(date: .day(0)),
    Download(date: .day(-1)),
    Download(date: .day(-2)),
    Download(date: .day(-3)),
    Download(date: .day(-4)),
    Download(date: .day(-5)),
    Download(date: .day(-6))
]
var appDownload2: [Download]=[
    Download(date: .day(0)),
    Download(date: .day(-1)),
    Download(date: .day(-2)),
    Download(date: .day(-3)),
    Download(date: .day(-4)),
    Download(date: .day(-5)),
    Download(date: .day(-6))
]
var appDownload3: [Download]=[
    Download(date: .day(0)),
    Download(date: .day(-1)),
    Download(date: .day(-2)),
    Download(date: .day(-3)),
    Download(date: .day(-4)),
    Download(date: .day(-5)),
    Download(date: .day(-6))
]
