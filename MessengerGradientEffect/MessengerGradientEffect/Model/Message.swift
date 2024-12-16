//
//  Message.swift
//  MessengerGradientEffect
//
//  Created by 曾品瑞 on 2024/10/4.
//

import SwiftUI

struct Message: Identifiable {
    var id: UUID=UUID()
    var message: String
    var reply: Bool=false
}

let message: [Message]=[
    Message(message: "The University Emblem of National Chung Cheng University, designed by Professor Mao-sheng Su of National Normal University, was approved by the First Committee for Faculty Senate on October 18th, 1988. The design of the Emblem includes two parts: the two center characters of ‘Chung Cheng’ and the five pen-pointed tips which symbolize the five founding colleges of the university (College of Humanities, College of Sciences, College of Social Sciences, College of Engineering, and College of Management)."),
    Message(message: "It is our hope that CCU will reach her goal of providing higher education in the areas of humanities, social sciences, and science and technologies through the collaboration of the five colleges. The Emblem signifies the spirit of our perpetual striving for self-improvement."),
    Message(message: "Earnestness is an ideal, a mentality, as well as an action. Earnestness is exhibited by thinking positively, aspiring on the bright side, and following the right path with perseverance to realize an ideal. Innovation is one of the major functions of university research. Pursuing the truth and discovering /creating new knowledge are all acts of innovation. Being virtuous encompasses accepting traditional virtues, following modern norms, and possessing forward thinking and values.", reply: true),
    Message(message: "Earnestness leads to diligence and great achievement; innovation leads to vibrant progress; being virtuous leads to high morality – all are not just for the benefit of an individual, but for the harmony, happiness, and progress of the human society. This is exact what ‘altruism’, the last part of the University Motto, implies.", reply: true),
    Message(message: "Great mountains and vast oceans"),
    Message(message: "Look around us, there’re plains of meadow green", reply: true),
    Message(message: "With words before actions that lead to righteousness"),
    Message(message: "we shall be elated with our aspiration"),
    Message(message: "With words before actions that lead to righteousness"),
    Message(message: "we shall be elated with our aspiration", reply: true),
    Message(message: "Research, instruction, and service – we accomplish our ideals", reply: true),
    Message(message: "Ethics, democracy, and science – we steer our goals"),
    Message(message: "Pursuing fame of the eternities, with altruism", reply: true),
    Message(message: "We shall model ourselves after the saints and sages")
]
