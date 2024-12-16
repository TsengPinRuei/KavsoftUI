//
//  Particle.swift
//  TextParticle
//
//  Created by Justin on 11/18/24.
//

import SwiftUI

struct Particle {
    var x: Double
    var y: Double
    let baseX: Double
    let baseY: Double
    let density: Double
    let power: Double
    
    mutating func update(position: CGPoint?, velocity: CGSize?) {
        let x: Double=self.baseX-self.x
        let y: Double=self.baseY-self.y
        let distance: Double=sqrt(pow(x, 2)+pow(y, 2))
        let forceX: Double=x/distance
        let forceY: Double=y/distance
        let maxDistance: Double=280
        let force: Double=(maxDistance-distance)/maxDistance
        let directionX: Double=forceX*force*self.density
        let directionY: Double=forceY*force*self.density
        
        if(distance<30) {
            self.x+=directionX*0.01
            self.y+=directionY*0.01
        } else if(distance<maxDistance) {
            self.x+=directionX*2.5
            self.y+=directionY*2.5
        } else {
            if(self.x != self.baseX) {
                self.x-=(self.x-self.baseX)/10
            }
            if(self.y != self.baseY) {
                self.y-=(self.y-self.baseY)/10
            }
        }
        
        if let position=position {
            let dragX: Double=self.x-position.x
            let dragY: Double=self.y-position.y
            var velocityF: Double=0
            
            if let velocity=velocity {
                velocityF=max(abs(velocity.width),abs(velocity.height))
            }
            
            let dragDistance=sqrt(pow(dragX,2)+pow(dragY,2))
            let dragForce=(200-min(dragDistance, 200))/200+velocityF*self.power
            self.x+=dragX*dragForce/2
            self.y+=dragY*dragForce/2
        }
    }
}
