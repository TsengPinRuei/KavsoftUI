//
//  HomeView.swift
//  ShapeMorphingEffect
//
//  Created by 曾品瑞 on 2024/10/8.
//

import SwiftUI

struct HomeView: View {
    @State private var current: Page=Page.page1
    
    @ViewBuilder
    private func ContinueView() -> some View {
        Button {
            self.current=self.current.next
        } label: {
            Text(self.current==Page.page4 ? "Back To School":"Continue")
                .contentTransition(.numericText())
                .bold()
                .font(.title3)
                .foregroundStyle(.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .background(.white, in: .capsule)
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: self.current)
    }
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Button {
                self.current=self.current.previous
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .contentShape(.rect)
            }
            .opacity(self.current != Page.page1 ? 1:0)
            
            Spacer(minLength: 0)
            
            Button(self.current==Page.page4 ? "AGAIN":"SKIP") {
                self.current=self.current==Page.page4 ? Page.page1:Page.page4
            }
            .contentTransition(.numericText())
        }
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .animation(.snappy(duration: 0.5, extraBounce: 0), value: self.current)
        .padding()
    }
    @ViewBuilder
    private func IndicatorView() -> some View {
        HStack(spacing: 10) {
            ForEach(Page.allCases, id: \.rawValue) {page in
                Capsule()
                    .fill(.white.opacity(self.current==page ? 1:0.5))
                    .frame(width: self.current==page ? 30:10, height: 10)
            }
        }
        .animation(.smooth(duration: 0.5, extraBounce: 0), value: self.current)
    }
    @ViewBuilder
    private func TextView(size: CGSize) -> some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) {page in
                    Text(page.title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: size.width)
                }
            }
            .offset(x: -self.current.index*size.width)
            .animation(.smooth(duration: 0.5, extraBounce: 0.25), value: self.current)
            
            HStack(alignment: .top, spacing: 0) {
                ForEach(Page.allCases, id: \.rawValue) {page in
                    Text(page.subtitle)
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .frame(width: size.width)
                }
            }
            .offset(x: -self.current.index*size.width)
            .animation(.smooth(duration: 0.7, extraBounce: 0.3), value: self.current)
        }
        .padding(.vertical)
        .frame(width: size.width, alignment: .leading)
    }
    
    var body: some View {
        GeometryReader {
            let size: CGSize=$0.size
            
            VStack {
                Spacer(minLength: 0)
                
                MorphingView(
                    symbol: self.current.rawValue,
                    configuration:
                        MorphingView.Configuration(
                            font: .system(size: 200, weight: .bold),
                            foreground: .white,
                            frame: CGSize(width: 300, height: 300),
                            radius: 30
                        )
                )
                
                self.TextView(size: size)
                
                Spacer(minLength: 0)
                
                VStack(spacing: 20) {
                    self.IndicatorView()
                    
                    self.ContinueView()
                }
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                self.HeaderView()
            }
        }
        .background {
            Rectangle()
                .fill(.black.gradient)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    HomeView()
}
