//
//  HomeView.swift
//  AppStoreHeroAnimation
//
//  Created by 曾品瑞 on 2024/3/20.
//

import SwiftUI
struct HomeView: View {
    @Environment(\.colorScheme) private var scheme
    
    @Namespace private var animation
    
    @State private var animateContext: Bool=false
    @State private var animateView: Bool=false
    @State private var show: Bool=false
    @State private var scroll: CGFloat=0
    @State private var current: Today?
    
    private let backgroundColor: Color=Color.gray.opacity(0.2)
    private var context: String=""
    
    @ViewBuilder
    private func DetailView(today: Today) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                self.TodayView(today: today).scaleEffect(self.animateView ? 1:0.9)
                
                VStack(spacing: 20) {
                    Text(self.context)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)
                    
                    Divider()
                    
                    Button {
                        
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up.fill")
                            .foregroundStyle(.primary)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 10, style: .continuous))
                    }
                }
                .padding()
                .offset(y: self.scroll>0 ? self.scroll:0)
                .opacity(self.animateContext ? 1:0)
                .scaleEffect(self.animateView ? 1:0, anchor: .top)
            }
            .offset(y: self.scroll>0 ? -self.scroll:0)
            .offset(offset: self.$scroll)
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation(.snappy(duration: 0.5)) {
                    self.animateView=false
                    self.animateContext=false
                }
                withAnimation(.snappy(duration: 0.5).delay(0.05)) {
                    self.current=nil
                    self.show=false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.white)
            }
            .padding()
            .padding(.top, self.safeArea().top)
            .offset(y: -10)
            .opacity(self.animateView ? 1:0)
        }
        .onAppear {
            withAnimation(.snappy(duration: 0.5)) {
                self.animateView=true
            }
            withAnimation(.snappy(duration: 0.5).delay(0.1)) {
                self.animateContext=true
            }
        }
        .transition(.identity)
    }
    @ViewBuilder
    private func TodayView(today: Today) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            ZStack(alignment: .topLeading) {
                GeometryReader {reader in
                    let size: CGSize=reader.size
                    
                    Image(today.work)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, topTrailing: 20)))
                }
                .frame(height: 400)
                
                LinearGradient(
                    colors: [
                        (self.scheme == .dark ? Color.black:Color.white).opacity(0.5),
                        (self.scheme == .dark ? Color.black:Color.white).opacity(0.25),
                        .clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(today.platform.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                    
                    Text(today.title)
                        .bold()
                        .font(.largeTitle)
                }
                .foregroundStyle(Color.primary)
                .multilineTextAlignment(.leading)
                .padding()
                .offset(y: self.current?.id==today.id && self.animateView ? self.safeArea().top:0)
            }
            
            HStack(spacing: 10) {
                Image(today.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .padding(10)
                    .background(.ultraThickMaterial)
                    .clipShape(.rect(cornerRadius: 20, style: .continuous))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(today.platform.uppercased())
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text(today.name).bold()
                    
                    Text(today.description)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .foregroundStyle(Color.primary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    
                } label: {
                    Text("GET")
                        .bold()
                        .foregroundStyle(.blue)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial, in: .capsule)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .background(self.backgroundColor.gradient, in: .rect(cornerRadius: 20, style: .continuous))
        .matchedGeometryEffect(id: today.id, in: self.animation)
    }
    
    init() {
        let alphabet: String="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        
        for _ in 0...1000 {
            self.context.append(alphabet.randomElement()!)
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("MONDAY 27 SEPTEMBER")
                            .font(.callout)
                            .foregroundStyle(.gray)
                        
                        Text("Today").bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button("", systemImage: "person.circle.fill") {
                    }
                }
                .font(.largeTitle)
                .padding(.horizontal)
                .padding(.bottom)
                .padding(self.show ? 0:1)
                
                ForEach(AppStoreHeroAnimation.today) {today in
                    Button {
                        withAnimation(.snappy(duration: 0.5)) {
                            self.current=today
                            self.show=true
                        }
                    } label: {
                        self.TodayView(today: today)
                            .scaleEffect(self.current?.id==today.id && self.show ? 1:0.9)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .opacity(self.show ? (self.current?.id==today.id ? 1:0):1)
                }
            }
            .padding(.vertical)
        }
        .overlay {
            if let current=self.current, self.show {
                self.DetailView(today: current).ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(self.backgroundColor.gradient)
                .frame(height: self.animateView ? nil:350, alignment: .top)
                .scaleEffect(self.animateView ? 1:0.9)
                .opacity(self.animateView ? 1:0)
                .ignoresSafeArea()
        }
    }
}
