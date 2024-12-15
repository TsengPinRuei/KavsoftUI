//
//  NewTaskView.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/11.
//

import SwiftUI
import SwiftData

struct NewTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var tint: String="Black"
    @State private var title: String=""
    @State private var type: String=""
    @State private var date: Date=Date()
    @State private var result: (Bool, String)=(false, "")
    
    private let color: [String]=["Red", "Orange", "Yellow", "Green", "Blue", "Purple"]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Label("New Task", systemImage: "arrow.left")
                    .bold()
                    .padding(.leading, -20)
                    .onTapGesture {
                        self.dismiss()
                    }
                
                VStack(spacing: 5) {
                    TextField("Title", text: self.$title)
                    
                    Divider()
                }
                .font(.title)
                .padding(.top)
            }
            .horizontalSpacing(.leading)
            .padding(30)
            .frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea(.all)
            }
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(spacing: 5) {
                    TextField("Type", text: self.$type)
                    
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Timeline")
                    
                    DatePicker("", selection: self.$date).datePickerStyle(.compact)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Color")
                    
                    HStack(spacing: 10) {
                        ForEach(self.color, id: \.self) {color in
                            Circle()
                                .fill(Tasks(title: "", type: "", tint: color).setColor())
                                .background {
                                    Circle()
                                        .stroke(lineWidth: 5)
                                        .opacity(self.tint==color ? 1:0)
                                }
                                .horizontalSpacing(.center)
                                .onTapGesture {
                                    withAnimation(.easeInOut.speed(2)) {
                                        self.tint=color
                                    }
                                }
                        }
                    }
                }
            }
            .font(.title2)
            .padding(30)
            .verticalSpacing(.top)
            
            Button {
                let task: Tasks=Tasks(title: self.title, type: self.type, date: self.date, tint: self.tint)
                
                do {
                    self.modelContext.insert(task)
                    try self.modelContext.save()
                    self.result.1="A task is added."
                } catch {
                    self.result.1=error.localizedDescription
                }
                self.result.0.toggle()
            } label: {
                Text("Create Task")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal, 30)
            }
        }
        .verticalSpacing(.top)
        .alert(self.result.1.starts(with: "A ") ? "Success!":"Oops!", isPresented: self.$result.0) {
            Button("Dismiss", role: .cancel) {
                self.dismiss()
            }
            
            if(self.result.1.starts(with: "A ")) {
                Button("Stay") {
                    withAnimation(.smooth) {
                        self.title=""
                        self.type=""
                        self.tint="Black"
                        self.date=Date()
                        self.result.1=""
                    }
                }
            }
        } message: {
            Text(self.result.1)
        }
    }
}
