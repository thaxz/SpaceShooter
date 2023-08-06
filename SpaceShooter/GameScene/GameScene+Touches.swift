//
//  GameScene+Touches.swift
//  SpaceShooter
//
//  Created by thaxz on 05/08/23.
//

import Foundation
import SpriteKit

// MARK: Touches

extension GameScene {
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        setupScene()
        makePlayer(playerCh: shipChoice.integer(forKey: "playerChoice"))
        addLives(lives: 3)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // the location of the touch in the view
            let location = touch.location(in: self)
            // adding this location to the player
            player.position.x = location.x
        }
    }
    
    
    
}
