//
//  AppIntent.swift
//  ChartWidget
//
//  Created by 曾品瑞 on 2023/12/3.
//

import WidgetKit
import AppIntents
import SwiftUI

struct ChartTint: AppEntity {
    static var defaultQuery: ChartTintQuery=ChartTintQuery()
    static var typeDisplayRepresentation: TypeDisplayRepresentation="Chart Tint"
    
    var id: UUID=UUID()
    var name: String
    var color: Color
    
    var displayRepresentation: DisplayRepresentation {
        return DisplayRepresentation(title: "\(self.name)")
    }
}

struct ChartTintQuery: EntityQuery {
    func defaultResult() async -> ChartTint? {
        return chartTint.first
    }
    func entities(for identifiers: [ChartTint.ID]) async throws -> [ChartTint] {
        return chartTint.filter {tint in
            identifiers.contains(where: { $0==tint.id })
        }
    }
    func suggestedEntities() async throws -> [ChartTint] {
        return chartTint
    }
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")
    
    @Parameter(title: "Line Chart", default: false) var isLine: Bool
    @Parameter(title: "Chart Tint") var chartTint: ChartTint?
}

struct TabButton: AppIntent {
    static var title: LocalizedStringResource="Tab Button"
    
    @Parameter(title: "App ID", default: "")
    
    var appID: String
    
    init() {
        
    }
    init(appID: String) {
        self.appID=appID
    }
    
    func perform() async throws -> some IntentResult {
        UserDefaults.standard.setValue(self.appID, forKey: "selectApp")
        return .result()
    }
}

var chartTint: [ChartTint]=[
    ChartTint(name: "Red", color: .red),
    ChartTint(name: "Orange", color: .orange),
    ChartTint(name: "Yellow", color: .yellow),
    ChartTint(name: "Green", color: .green),
    ChartTint(name: "Blue", color: .blue),
    ChartTint(name: "Purple", color: .purple)
]
