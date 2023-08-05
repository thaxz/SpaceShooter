//
//  GameScene+Collisions.swift
//  SpaceShooter
//
//  Created by thaxz on 05/08/23.
//

import Foundation
import SpriteKit

// MARK: Collisions

extension GameScene {
    
    // When the contact begins
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA: SKPhysicsBody
        let contactB: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            contactA = contact.bodyA
            contactB = contact.bodyB
        } else {
            contactA = contact.bodyB
            contactB = contact.bodyA
        }
        
        // if there's a contact between a fire and an enemy
        if contactA.categoryBitMask == CBitmask.playerFire && contactB.categoryBitMask == CBitmask.enemyShip {
            addPoint()
            updateScore()
            fireHitEnemy(fires: contactA.node as! SKSpriteNode, enemies: contactB.node as! SKSpriteNode)
        }
        // if there's a contact between the enemy and the ship
        if contactA.categoryBitMask == CBitmask.playerShip && contactB.categoryBitMask == CBitmask.enemyShip {
            
            player.run(SKAction.repeat(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.fadeIn(withDuration: 0.1)]), count: 8))
            
            contactB.node?.removeFromParent()
            
            if let live1 = childNode(withName: "live1"){
                live1.removeFromParent()
            } else if let live2 = childNode(withName: "live2"){
                live2.removeFromParent()
            } else if let live3 = childNode(withName: "live3"){
                live3.removeFromParent()
                player.removeFromParent()
                fireTimer.invalidate()
                enemyTimer.invalidate()
                passGameOver()
            }
            
           // playerHitEnemy(players: contactA.node as! SKSpriteNode  , enemies: contactB.node as! SKSpriteNode)
      
        }
    }
    
    
}

