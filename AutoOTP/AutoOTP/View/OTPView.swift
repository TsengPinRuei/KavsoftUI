//
//  OTPView.swift
//  AutoOTP
//
//  Created by 曾品瑞 on 2023/11/13.
//

import SwiftUI

struct OTPView: View {
    @FocusState private var keyboard: Bool
    
    @State private var otp: String=""
    
    @ViewBuilder
    private func otpBox(_ index: Int) -> some View {
        ZStack {
            if(self.otp.count>index) {
                Text(String(self.otp[self.otp.index(self.otp.startIndex, offsetBy: index)]))
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(self.keyboard && self.otp.count==index ? .black:.gray, lineWidth: self.keyboard && self.otp.count==index ? 2:1)
                .animation(.smooth.speed(2), value: self.keyboard && self.otp.count==index)
        }
        .frame(maxWidth: .infinity)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 0) {
                    ForEach(0..<6) {index in
                        self.otpBox(index)
                    }
                }
                .background {
                    TextField("", text: self.$otp.limit(6))
                        .focused(self.$keyboard)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .frame(width: 1, height: 1)
                        .opacity(0.001)
                        .blendMode(.screen)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.keyboard.toggle()
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                Button {
                    withAnimation(.smooth) {
                        self.otp=""
                    }
                } label: {
                    Text("Verify")
                        .bold()
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(.black, in: .rect(cornerRadius: 10, style: .continuous))
                }
                .disableWithOpacity(self.otp.count<6)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Verify OTP")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        self.keyboard.toggle()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }
}
