//
//  CMTime.swift
//  YouTubeVideoPlayer
//
//  Created by 曾品瑞 on 2024/4/19.
//

import SwiftUI
import AVKit

extension CMTime {
    func timeString() -> String {
        let round: Double=seconds.rounded()
        let hour: Int=Int(round/3600)
        let minute: Int=Int(round.truncatingRemainder(dividingBy: 3600)/60)
        let second: Int=Int(round.truncatingRemainder(dividingBy: 60))
        return hour>0 ? String(format: "%d:%02d:%02d", hour, minute, second):String(format: "%02d:%02d", minute, second)
    }
}
