//
//  ContextView.swift
//  GridAnimation
//
//  Created by 曾品瑞 on 2024/5/10.
//

import SwiftUI

struct ContextView: View {
    @ViewBuilder
    private func ImageView(_ image: String) -> some View {
        GeometryReader {
            let size: CGSize=$0.size
            let number: Int=Int.random(in: 1...12)
            
            Image("nature\(number)")
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .frame(height: 200)
    }
    private func SectionView(title: String, long: Bool=false) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .bold()
                .font(.title)
            
            Text("In the quiet stillness of dawn, the world seemed to hold its breath, waiting for the sun's gentle caress to awaken it from slumber. Dew glistened like scattered diamonds upon the velvety petals of flowers, while the soft murmur of a nearby stream provided a soothing soundtrack to nature's morning symphony. Birds, with their melodious songs, painted the air with vibrant hues of sound, adding to the tranquil atmosphere that enveloped the landscape. It was a moment frozen in time, a fleeting glimpse of pure serenity before the hustle and bustle of the day began anew.\(long ? "As the world slowly stirred awake, shadows danced playfully upon the earth, stretching and reaching towards the warmth of the rising sun. A gentle breeze whispered through the leaves, carrying with it the promise of another day filled with endless possibilities and untold adventures waiting to unfold beneath the azure sky.":"")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(Array(stride(from: 1, to: 5, by: 2)), id: \.self) {index in
                self.SectionView(title: "Section \(index)").padding(.leading)
                
                self.SectionView(title: "Section \(index+1)", long: true).padding(.horizontal)
                
                self.ImageView("nature")
            }
        }
        .padding(.vertical)
    }
}
