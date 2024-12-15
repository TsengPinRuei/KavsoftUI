//
//  RowView.swift
//  ToDoList
//
//  Created by 曾品瑞 on 2024/2/6.
//

import SwiftUI
import WidgetKit

struct RowView: View {
    @Bindable var toDo: ToDo
    
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var phase
    
    @FocusState private var active: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            if(!self.active && !self.toDo.task.isEmpty) {
                Button {
                    self.toDo.complete.toggle()
                    self.toDo.update=Date.now
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Image(systemName: self.toDo.complete ? "checkmark.circle.fill":"circle")
                        .font(.title2)
                        .foregroundStyle(self.toDo.complete ? .gray:.accentColor)
                        .padding(5)
                        .contentShape(.rect)
                        .contentTransition(.symbolEffect(.replace))
                }
            }
            
            TextField("", text: self.$toDo.task)
                .submitLabel(.done)
                .foregroundStyle(self.toDo.complete ? .gray:.primary)
                .strikethrough(self.toDo.complete)
                .focused(self.$active)
            
            if(!self.active && !self.toDo.task.isEmpty) {
                Menu {
                    ForEach(Priority.allCases, id: \.rawValue) {priority in
                        Button {
                            self.toDo.priority=priority
                        } label: {
                            HStack {
                                Text(priority.rawValue)
                                
                                if(self.toDo.priority==priority) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    Image(systemName: "circle.fill")
                        .font(.title2)
                        .foregroundStyle(self.toDo.priority.color.gradient)
                        .padding(5)
                        .contentShape(.rect)
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .animation(.snappy, value: self.active)
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("", systemImage: "trash") {
                self.context.delete(self.toDo)
                WidgetCenter.shared.reloadAllTimelines()
            }
            .tint(.red)
        }
        .onSubmit(of: .text) {
            if(self.toDo.task.isEmpty) {
                self.context.delete(self.toDo)
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .onChange(of: self.phase) {(_, new) in
            if(new != .active && self.toDo.task.isEmpty) {
                self.context.delete(self.toDo)
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .task {
            self.toDo.complete=self.toDo.complete
        }
        .onAppear {
            self.active=self.toDo.task.isEmpty
        }
    }
}
