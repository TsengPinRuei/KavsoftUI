//
//  HomeView.swift
//  LotteryGeometryEffect
//
//  Created by 曾品瑞 on 2023/12/13.
//

import SwiftUI

struct HomeView: View {
    @Namespace private var animation
    
    @State private var expand: Bool=false
    @State private var show: Bool=false
    
    @ViewBuilder
    private func CardView() -> some View {
        GeometryReader {reader in
            let size: CGSize=reader.size
            let frame: CGFloat=size.width*0.9
            
            ScratchView(point: 50) {
                if(!self.expand) {
                    self.GiftView(width: frame, height: frame).matchedGeometryEffect(id: "GIFTCARD", in: self.animation)
                }
            } overlay: {
                Image(.card)
                    .resizable()
                    .scaledToFill()
                    .frame(width: frame, height: frame, alignment: .topLeading)
                    .overlay(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
            } finish: {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    withAnimation(.bouncy) {
                        self.expand=true
                    }
                }
            }
            .frame(width: size.width, height: size.height, alignment: .center)
        }
        .padding()
    }
    @ViewBuilder
    private func GiftView(width: CGFloat, height: CGFloat) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "trophy.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.yellow)
                .frame(width: 150, height: 150)
            
            Text("Congratulations!").font(.title3)
            
            HStack {
                Image(systemName: "apple.logo")
                
                Text("$\(Int.random(in: 0...100))")
            }
            .bold()
            .font(.title)
            .foregroundStyle(.black)
        }
        .frame(maxWidth: width, maxHeight: height)
        .overlay(alignment: .topLeading) {
            Image(.apple)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding([.top, .leading], 10)
        }
        .background(.gray.gradient)
        .clipShape(.rect(cornerRadius: 20))
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "apple.logo").offset(y: -5)
                    
                    Text("Pay")
                }
                .font(.largeTitle)
                
                Spacer(minLength: 0)
                
                Button("BACK") {}
            }
            .bold()
            
            self.CardView()
            
            Text("Hello, there!")
                .bold()
                .font(.title)
            
            Text("Let see what inside the card!")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            Button {} label: {
                Text("VIEW RESULT")
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.linearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing)))
            }
            .padding(.top)
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(red: 50/255, green: 50/255, blue: 100/255).ignoresSafeArea())
        .overlay {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(self.show ? 1:0)
                .ignoresSafeArea()
        }
        .overlay {
            GeometryReader {reader in
                let size: CGSize=reader.size
                let frame: CGFloat=size.width*0.9
                
                if(self.expand) {
                    self.GiftView(width: frame, height: frame)
                        .overlay {
                            if(self.show) {
                                RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1)
                            }
                        }
                        .matchedGeometryEffect(id: "GIFTCARD", in: self.animation)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(x: 1)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.show=true
                            }
                        }
                }
            }
            .padding()
            .padding()
        }
        .overlay(alignment: .topTrailing) {
            if(self.show) {
                Button {
                    withAnimation(.smooth(duration: 0.3)) {
                        self.show=false
                    }
                    
                    withAnimation(.smooth(duration: 0.3).delay(0.1)) {
                        self.expand=false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundStyle(Color.primary)
                        .padding()
                }
                .transition(.opacity)
            }
        }
    }
}
