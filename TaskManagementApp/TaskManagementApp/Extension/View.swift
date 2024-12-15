//
//  View.swift
//  TaskManagementApp
//
//  Created by 曾品瑞 on 2023/11/11.
//

import SwiftUI

extension View {
    @ViewBuilder
    func horizontalSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    @ViewBuilder
    func verticalSpacing(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}
