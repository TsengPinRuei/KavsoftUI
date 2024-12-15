//
//  CompleteView.swift
//  ToDoList
//
//  Created by 曾品瑞 on 2024/2/6.
//

import SwiftUI
import SwiftData

struct CompleteView: View {
    @Binding var show: Bool
    
    @Query private var complete: [ToDo]
    
    init(show: Binding<Bool>) {
        let predicate: Predicate=#Predicate<ToDo> { $0.complete }
        let sort: [SortDescriptor]=[SortDescriptor(\ToDo.update, order: .reverse)]
        var descriptor: FetchDescriptor=FetchDescriptor(predicate: predicate, sortBy: sort)
        
        if(!show.wrappedValue) {
            descriptor.fetchLimit=5
        }
        
        self._show=show
        self._complete=Query(descriptor, animation: .snappy)
    }
    
    var body: some View {
        Section {
            ForEach(self.complete) {
                RowView(toDo: $0)
            }
        } header: {
            HStack {
                Text("Complete")
                
                Spacer(minLength: 0)
                
                if(self.show && !self.complete.isEmpty) {
                    Button("Show Recent") {
                        self.show=false
                    }
                }
            }
            .font(.caption)
        } footer: {
            if(self.complete.count==5 && !self.show && !self.complete.isEmpty) {
                HStack {
                    Text("Show Recent 15 Task").foregroundStyle(.gray)
                    
                    Spacer(minLength: 0)
                    
                    Button("Show All") {
                        self.show=true
                    }
                }
                .font(.caption)
            }
        }
    }
}
