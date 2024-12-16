//
//  Tab.swift
//  YouTubePlayerAnimation
//
//  Created by 曾品瑞 on 2024/3/11.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home="Home"
    case short="Short"
    case subscription="Subscription"
    case you="You"
    
    var symbol: String {
        switch(self) {
        case .home: "house.fill"
        case .short: "video.badge.waveform.fill"
        case .subscription: "play.square.stack.fill"
        case .you: "person.circle.fill"
        }
    }
}
