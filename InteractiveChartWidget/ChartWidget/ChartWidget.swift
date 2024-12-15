//
//  ChartWidget.swift
//  ChartWidget
//
//  Created by 曾品瑞 on 2023/12/3.
//

import WidgetKit
import SwiftUI
import Charts

struct ChartWidget: Widget {
    let kind: String="ChartWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ChartWidgetEntryView(entry: entry).containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemLarge, .systemExtraLarge])
    }
}

struct ChartWidgetEntryView: View {
    @AppStorage("selectApp") private var selectApp: String="App 1"
    
    var entry: Provider.Entry
    
    var selectDownload: [Download] {
        return self.entry.app.first(where: { $0.id==self.selectApp })?.download ?? []
    }
    var selectIndex: Int {
        return self.entry.app.firstIndex(where: { $0.id==self.selectApp }) ?? 0
    }
    
    private func dayString(_ date: Date) -> String {
        let format: DateFormatter=DateFormatter()
        format.dateFormat="EEE"
        return format.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("App Download")
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Last 7 days: ")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, -10)
            
            let tint: Color=self.entry.configuration.chartTint?.color ?? .black
            HStack(spacing: 0) {
                ForEach(self.entry.app) {app in
                    Button(intent: TabButton(appID: app.id)) {
                        Text(app.id)
                            .font(.caption)
                            .foregroundStyle(app.id==self.selectApp ? .white:.primary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .lineLimit(1)
                    }
                    .buttonStyle(.plain)
                }
            }
            .background {
                GeometryReader {
                    let size: CGSize=$0.size
                    let width: CGFloat=size.width/CGFloat(self.entry.app.count)
                    
                    Capsule()
                        .fill(tint.gradient)
                        .frame(width: width)
                        .offset(x: width*CGFloat(self.selectIndex))
                }
            }
            .frame(height: 30)
            .background(.primary.opacity(0.2), in: .capsule)
            
            Chart(self.selectDownload) {download in
                if(self.entry.configuration.isLine) {
                    LineMark(
                        x: .value("Day", self.dayString(download.date)),
                        y: .value("Download", download.value)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(tint)
                    
                    AreaMark(
                        x: .value("Day", self.dayString(download.date)),
                        y: .value("Download", download.value)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.linearGradient(colors: [tint, tint.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom))
                } else {
                    BarMark(
                        x: .value("Day", self.dayString(download.date)),
                        y: .value("Download", download.value)
                    )
                    .foregroundStyle(tint.gradient)
                }
            }
        }
    }
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), app: app)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, app: app)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry]=[]
        
        let entry: SimpleEntry=SimpleEntry(date: .now, configuration: configuration, app: app)
        entries.append(entry)
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let app: [AppModel]
}
