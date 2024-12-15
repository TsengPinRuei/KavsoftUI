//
//  HomeView.swift
//  ToDoList
//
//  Created by 曾品瑞 on 2024/2/6.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    
    @Query(
        filter: #Predicate<ToDo> { !$0.complete },
        sort: [SortDescriptor(\ToDo.update, order: .reverse)],
        animation: .snappy
    ) private var list: [ToDo]
    
    @State private var show: Bool=false
    
    private var title: String {
        let count: Int=self.list.count
        return count==0 ? "Active":"Active (\(count))"
    }
    
    var body: some View {
        List {
            Section(self.title) {
                ForEach(self.list) {
                    RowView(toDo: $0)
                }
            }
            
            CompleteView(show: self.$show)
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    let toDo: ToDo=ToDo(task: "", priority: .normal)
                    self.context.insert(toDo)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .fontWeight(.light)
                        .font(.largeTitle)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
