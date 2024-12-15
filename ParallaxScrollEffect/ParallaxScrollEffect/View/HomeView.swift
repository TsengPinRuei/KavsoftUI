//
//  HomeView.swift
//  ParallaxScrollEffect
//
//  Created by 曾品瑞 on 2023/12/29.
//

import SwiftUI

struct HomeView: View {
    
    @ViewBuilder
    private func SectionView(title: String, long: Bool=false) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .bold()
                .font(.title)
            
            Text("In a world often defined by challenges, cultivating a positive mindset can be a game-changer. Research suggests that optimistic thinking not only enhances mental well-being but also contributes to overall success. By focusing on solutions rather than problems, individuals can navigate obstacles with resilience and creativity. Positive thinking fosters a can-do attitude, fostering a sense of empowerment and motivation. It doesn't imply denying difficulties but reframing them as opportunities for growth. Embracing positivity can improve relationships, boost productivity, and enhance physical health. As we navigate life's complexities, adopting a positive perspective emerges as a powerful tool for personal and professional triumphs. \(long ? "In addition to its psychological benefits, positive thinking has profound effects on physical health. Studies show that maintaining an optimistic outlook can lead to lower stress levels and improved cardiovascular health. Furthermore, individuals with positive attitudes tend to engage in healthier lifestyle choices. Harnessing the power of positivity not only transforms the mind but also positively influences one's overall well-being, creating a ripple effect that extends to various aspects of life. Embracing optimism becomes a holistic approach to achieving success and happiness.":"")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                self.SectionView(title: "Power of Positive Thinking")
                
                self.SectionView(title: "Key To Success", long: true)
                
                ParallaxImageView(full: true) {size in
                    Image(.landscape1)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 300)
                
                self.SectionView(title: "Power of Positive Thinking")
                
                self.SectionView(title: "Key To Success", long: true)
                
                ParallaxImageView(full: true, move: 200) {size in
                    Image(.landscape2)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 400)
                
                self.SectionView(title: "Power of Positive Thinking")
                
                self.SectionView(title: "Key To Success", long: true)
            }
            .padding()
        }
    }
}
