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
    var player = SKSpriteNode()
    var playerFire = SKSpriteNode()
    
    var fireTimer = Timer()
    
    // MARK: Touches
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 750, height: 1335)
        
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 1
        background.setScale(2)
        addChild(background)
        makePlayer(playerCh: 1)
        // calling this function every 0.5 seconds
        fireTimer = .scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(makePlayerFire), userInfo: nil, repeats: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // the location of the touch in the view
            let location = touch.location(in: self)
            // adding this location to the player
            player.position.x = location.x
        }
    }
    
    func makePlayer(playerCh: Int){
        
        var shipName = ""
        
        switch playerCh {
        case 1:
            shipName = "redShip"
        case 2:
            shipName = "blueShip"
        default:
            shipName = "whiteShip"
        }
        
        player = .init(imageNamed: shipName)
        player.position = CGPoint(x: size.width/2, y: 120)
        player.zPosition = 10
        player.setScale(0.5)
        addChild(player)
    }
    
     @objc func makePlayerFire(){
        playerFire = .init(imageNamed: "fire")
        playerFire.position = player.position
        playerFire.zPosition = 3
        addChild(playerFire)
        
        let moveAction = SKAction.moveTo(y: 1400, duration: 1)
        let deleteAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction, deleteAction])

        playerFire.run(combine)
    }
    
}
