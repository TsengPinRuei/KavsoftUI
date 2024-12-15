//
//  TaskView.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/12.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @Binding var date: Date
    
    @Query private var task: [Tasks]
    
    init(date: Binding<Date>) {
        self._date=date
        let calendar: Calendar=Calendar.current
        let start: Date=calendar.startOfDay(for: date.wrappedValue)
        let end: Date=calendar.date(byAdding: .day, value: 1, to: start)!
        self._task=Query(
            filter: #Predicate<Tasks> { return $0.date>=start && $0.date<end },
            sort: [SortDescriptor(\Tasks.date, order: .reverse)],
            animation: .snappy
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(self.task) {task in
                ItemView(task: task)
                    .background(alignment: .leading) {
                        if(self.task.last?.id != task.id) {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 25, y: 45)
                        }
                    }
            }
        }
        .padding(.top)
        .overlay {
            if(self.task.isEmpty) {
                Text("No task is added.")
                    .bold()
                    .font(.title)
                    .frame(width: 250)
            }
        }
    }
}
