//
//  Binding.swift
//  AutoOTP
//
//  Created by 曾品瑞 on 2023/11/13.
//

import SwiftUI

extension Binding where Value==String {
    func limit(_ count: Int) -> Self {
        if(self.wrappedValue.count>count) {
            DispatchQueue.main.async {
                self.wrappedValue=String(self.wrappedValue.prefix(count))
            }
        }
        return self
    }
}
