//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by 曾品瑞 on 2024/2/6.
//

import AppIntents
import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry: SimpleEntry=SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry]=[]
        let entry: SimpleEntry=SimpleEntry(date: .now)
        entries.append(entry)
        let timeline: Timeline=Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct ToDoWidgetEntryView : View {
    static var descriptor: FetchDescriptor<ToDo> {
        let predicate: Predicate=#Predicate<ToDo> { !$0.complete }
        let sort: [SortDescriptor]=[SortDescriptor(\ToDo.update, order: .reverse)]
        var fetch: FetchDescriptor=FetchDescriptor(predicate: predicate, sortBy: sort)
        fetch.fetchLimit=3
        return fetch
    }
    
    @Query(descriptor, animation: .snappy) private var query: [ToDo]
    
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            ForEach(self.query) {toDo in
                HStack(spacing: 10) {
                    Button(intent: ToggleButton(id: toDo.taskID)) {
                        Image(systemName: "circle")
                    }
                    .font(.callout)
                    .tint(toDo.priority.color.gradient)
                    .buttonBorderShape(.circle)
                    
                    Text(toDo.task)
                        .font(.callout)
                        .lineLimit(1)
                    
                    Spacer(minLength: 0)
                }
                .transition(.push(from: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay {
            if(self.query.isEmpty) {
                Text("No Task")
                    .font(.caption)
                    .transition(.push(from: .bottom))
            }
        }
    }
}

struct ToDoWidget: Widget {
    let kind: String="ToDoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: self.kind, provider: Provider()) {entry in
            ToDoWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .modelContainer(for: ToDo.self)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Task")
    }
}

struct ToggleButton: AppIntent {
    static var title: LocalizedStringResource=LocalizedStringResource(stringLiteral: "Toggle To Do State")
    
    @Parameter(title: "To Do ID")
    
    var id: String
    
    init() {
        
    }
    init(id: String) {
        self.id=id
    }
    
    func perform() async throws -> some IntentResult {
        let context: ModelContext=try ModelContext(.init(for: ToDo.self))
        let descriptor: FetchDescriptor=FetchDescriptor(predicate: #Predicate<ToDo> { $0.taskID==id })
        if let toDo=try context.fetch(descriptor).first {
            toDo.complete=true
            toDo.update=Date.now
            try context.save()
        }
        
        return .result()
    }
}

#Preview(as: .systemSmall) {
    ToDoWidget()
} timeline: {
    SimpleEntry(date: .now)
}
