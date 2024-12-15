//
//  AppModel.swift
//  ChartWidgetExtension
//
//  Created by 曾品瑞 on 2023/12/3.
//

import SwiftUI

struct AppModel: Identifiable {
    var id: String
    var name: String
    var download: [Download]
}

let app: [AppModel]=[
    AppModel(id: "App 1", name: "App 1", download: appDownload1),
    AppModel(id: "App 2", name: "App 2", download: appDownload2),
    AppModel(id: "App 3", name: "App 3", download: appDownload3)
]
