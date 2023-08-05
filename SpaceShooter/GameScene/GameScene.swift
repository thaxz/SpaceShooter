//
//  GameScene.swift
//  SpaceShooter
//
//  Created by thaxz on 02/08/23.
//

import Foundation
import SpriteKit
import GameKit

protocol GameLogicDelegate {
    
    var totalScore: Int { get }
    var isGameOver: Bool { get }
    
    mutating func addPoint() -> Void
    mutating func passGameOver() -> Void
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // delegate
    var gameLogicDelegate: GameLogicDelegate? = nil
    
    // MARK: Properties
    
    let background = SKSpriteNode(imageNamed: "background")
    
    var player = SKSpriteNode()
    var playerFire = SKSpriteNode()
    var fireTimer = Timer()
    
    var enemy = SKSpriteNode()
    var enemyTimer = Timer()
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    var livesArray = [SKSpriteNode]()
    
    var isGameOver: Bool = false
    
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
    
    
}

// MARK: - Trying to pass data by delegate
extension GameScene {
    
    func passGameOver(){
        if var gameLogicDelegate = self.gameLogicDelegate {
            gameLogicDelegate.passGameOver()
        }
    }
    
    func addPoint() {
        if var gameLogicDelegate = self.gameLogicDelegate {
            gameLogicDelegate.addPoint()
        }
    }
}
