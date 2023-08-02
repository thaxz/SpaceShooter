//
//  GameScene.swift
//  SpaceShooter
//
//  Created by thaxz on 02/08/23.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background")
    
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 750, height: 1335)
        
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 1
        background.setScale(2)
        addChild(background)
        
    }
    
    
    
    
}
