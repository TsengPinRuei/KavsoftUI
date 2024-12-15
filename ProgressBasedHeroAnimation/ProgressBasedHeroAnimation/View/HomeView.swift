//
//  HomeView.swift
//  ProgressBasedHeroAnimation
//
//  Created by 曾品瑞 on 2023/10/17.
//

import SwiftUI

struct HomeView: View {
    @State private var showDetail: Bool=false
    @State private var showHero: Bool=true
    @State private var progress: CGFloat=0
    @State private var current: Profile?
    @State private var profile: [Profile]=person
    
    var body: some View {
        NavigationStack {
            List(self.profile) {profile in
                HStack(spacing: 12) {
                    Image(profile.picture)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                        .opacity(self.current?.id==profile.id ? 0:1)
                        .anchorPreference(key: AnchorKey.self, value: .bounds) {anchor in
                            return [profile.id.uuidString:anchor]
                        }
                    
                    VStack(alignment: .leading) {
                        Text(profile.name).fontWeight(.semibold)
                        
                        Text(profile.message)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.current=profile
                    self.showDetail=true
                    
                    withAnimation(.snappy(duration: 0.35, extraBounce: 0), completionCriteria: .logicallyComplete) {
                        self.progress=1
                    } completion: {
                        Task {
                            try? await Task.sleep(for: .seconds(0.1))
                            self.showHero=false
                        }
                    }
                }
            }
            .navigationTitle("Profiles")
        }
        .overlay {
            if(self.showDetail) {
                DetailView(
                    showDetail: self.$showDetail,
                    showHero: self.$showHero,
                    progress: self.$progress,
                    profile: self.$current
                )
                .transition(.identity)
            }
        }
        .overlayPreferenceValue(AnchorKey.self) {value in
            GeometryReader {reader in
                if let current=self.current,
                   let source=value[current.id.uuidString],
                   let destination=value["DESTINATION"] {
                    let sourceRectangle=reader[source]
                    let radius=sourceRectangle.height/2
                    let destinationRectangle=reader[destination]
                    
                    let differenceOrigin=CGPoint(
                        x: destinationRectangle.minX-sourceRectangle.minX,
                        y: destinationRectangle.minY-sourceRectangle.minY
                    )
                    let differenceSize: CGSize=CGSize(
                        width: destinationRectangle.width-sourceRectangle.width,
                        height: destinationRectangle.height-sourceRectangle.height
                    )
                    
                    Image(current.picture)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: sourceRectangle.width+(differenceSize.width*self.progress),
                            height: sourceRectangle.height+(differenceSize.height*self.progress)
                        )
                        .clipShape(.rect(cornerRadius: radius))
                        .offset(
                            x: sourceRectangle.minX+(differenceOrigin.x*self.progress),
                            y: sourceRectangle.minY+(differenceOrigin.y*self.progress)
                        )
                        .opacity(self.showHero ? 1:0)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
