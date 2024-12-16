//
//  NatureModel.swift
//  ZoomTransition
//
//  Created by 曾品瑞 on 2024/10/5.
//

import SwiftUI
import AVKit

@Observable
class NatureModel {
    var nature: [Nature]=ZoomTransition.nature
    
    func generateNature(_ nature: Binding<Nature>, size: CGSize) async {
        do {
            let asset: AVURLAsset=AVURLAsset(url: nature.wrappedValue.url)
            let generate: AVAssetImageGenerator=AVAssetImageGenerator(asset: asset)
            generate.maximumSize=size
            generate.appliesPreferredTrackTransform=true
            
            let zero: CGImage=try await generate.image(at: .zero).image
            guard let base: CGImage=zero.copy(colorSpace: CGColorSpaceCreateDeviceRGB()) else { return }
            let image: UIImage=UIImage(cgImage: base)
            
            await MainActor.run {
                nature.wrappedValue.image=image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
