//
//  ItemView.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/11.
//

import SwiftUI

struct ItemView: View {
    @Bindable var task: Tasks
    
    var indicatorColor: Color {
        if(self.task.complete) {
            return .green
        } else if(self.task.date.isSameHour) {
            return .black
        } else if(self.task.date.isPast) {
            return .blue
        } else {
            return .black
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Circle()
                .fill(self.indicatorColor)
                .frame(width: 10, height: 10)
                .padding(5)
                .background(.white, in: .circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                self.task.complete.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(self.task.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Label("\(self.task.date.format("hh:mm a"))", systemImage: "clock").font(.callout)
                }
                .horizontalSpacing(.leading)
                
                Text(self.task.type).font(.callout)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(self.task.setColor().opacity(0.5))
            .clipShape(.rect(cornerRadius: 20))
        }
        .padding(.horizontal)
    }
}
