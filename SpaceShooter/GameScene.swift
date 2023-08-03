//
//  GameScene.swift
//  SpaceShooter
//
//  Created by thaxz on 02/08/23.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Properties
    
    let background = SKSpriteNode(imageNamed: "background")
    
    var player = SKSpriteNode()
    var playerFire = SKSpriteNode()
    var fireTimer = Timer()
    
    var enemy = SKSpriteNode()
    var enemyTimer = Timer()
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    // MARK: Touches
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        scene?.size = CGSize(width: 750, height: 1335)
        // setting bg (todo: move to an separed function)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 1
        background.setScale(2)
        addChild(background)
        makePlayer(playerCh: 1)
        // calling this function every 0.5 seconds (todo: move to other functions)
        fireTimer = .scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(makePlayerFire), userInfo: nil, repeats: true)
        enemyTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(makeEnemy), userInfo: nil, repeats: true)
        // setting score
        scoreLabel.text = "Score \(score)"
        scoreLabel.fontName = "HelveticaNeue-Bold"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .white
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height - 200 )
        addChild(scoreLabel)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // the location of the touch in the view
            let location = touch.location(in: self)
            // adding this location to the player
            player.position.x = location.x
        }
    }
    
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
            updateScore()
            fireHitEnemy(fires: contactA.node as! SKSpriteNode, enemies: contactB.node as! SKSpriteNode)
        }
        // if there's a contact between the enemy and the ship
        if contactA.categoryBitMask == CBitmask.playerShip && contactB.categoryBitMask == CBitmask.enemyShip {
            playerHitEnemy(players: contactA.node as! SKSpriteNode  , enemies: contactB.node as! SKSpriteNode)
      
        }
    }
    
    
    // MARK: Configues (todo: put on an extention)
    
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
        // physics body
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = CBitmask.playerShip
        player.physicsBody?.contactTestBitMask = CBitmask.enemyShip
        player.physicsBody?.collisionBitMask = CBitmask.enemyShip
        addChild(player)
    }
    
    @objc func makePlayerFire(){
        playerFire = .init(imageNamed: "fire")
        playerFire.position = player.position
        playerFire.zPosition = 3
        // physics
        playerFire.physicsBody = SKPhysicsBody(rectangleOf: playerFire.size)
        playerFire.physicsBody?.affectedByGravity = false
        playerFire.physicsBody?.categoryBitMask = CBitmask.playerFire
        playerFire.physicsBody?.contactTestBitMask = CBitmask.enemyShip
        playerFire.physicsBody?.collisionBitMask = CBitmask.enemyShip
        addChild(playerFire)
        
        let moveAction = SKAction.moveTo(y: 1400, duration: 1)
        let deleteAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction, deleteAction])
        
        playerFire.run(combine)
    }
    
    @objc func makeEnemy(){
        // creating texture and random position
        let randomNumer = GKRandomDistribution(lowestValue: 50, highestValue: 700)
        enemy = .init(imageNamed: "alien")
        enemy.position = CGPoint(x: randomNumer.nextInt(), y: 1400)
        enemy.zPosition = 5
        // physics body
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        addChild(enemy)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = CBitmask.enemyShip
        enemy.physicsBody?.contactTestBitMask = CBitmask.playerShip | CBitmask.playerFire
        enemy.physicsBody?.collisionBitMask = CBitmask.playerShip | CBitmask.playerFire
        
        // animating moves
        let moveAction = SKAction.moveTo(y: -100, duration: 2)
        let deleteAction = SKAction.removeFromParent()
        let combine = SKAction.sequence([moveAction, deleteAction])
        
        enemy.run(combine)
    }
    
    // when the player hits an enemy
    func playerHitEnemy(players: SKSpriteNode, enemies: SKSpriteNode){
        players.removeFromParent()
        enemies.removeFromParent()
        fireTimer.invalidate()
        enemyTimer.invalidate()
        
        let explo = SKEmitterNode(fileNamed: "ExplosionOne")
        explo?.position = players.position
        explo?.zPosition = 5
        addChild(explo!)
    }
    
    // when a fire hits an enemy
    func fireHitEnemy(fires: SKSpriteNode, enemies: SKSpriteNode){
        fires.removeFromParent()
        enemies.removeFromParent()
        
        let explo = SKEmitterNode(fileNamed: "ExplosionOne")
        explo?.position = enemies.position
        explo?.zPosition = 5
        addChild(explo!)
    }
    
    // updating score
    func updateScore(){
        score += 1
        scoreLabel.text = "Score \(score)"
    }
    
}
