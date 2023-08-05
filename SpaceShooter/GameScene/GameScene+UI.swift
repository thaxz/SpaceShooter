//
//  GameScene+UI.swift
//  SpaceShooter
//
//  Created by thaxz on 05/08/23.
//

import Foundation
import SpriteKit

// MARK: Configuring UI

extension GameScene {
    
    
    func setupScene(){
        scene?.size = CGSize(width: 750, height: 1335)
        setupTimers()
        setupBg()
        setupScore()
    }
    
    func setupTimers(){
        fireTimer = .scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(makePlayerFire), userInfo: nil, repeats: true)
        enemyTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(makeEnemy), userInfo: nil, repeats: true)
    }
    
    func setupBg(){
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = 1
        background.setScale(2)
        addChild(background)
    }
    
    func setupScore(){
        scoreLabel.text = "Score \(score)"
        scoreLabel.fontName = "HelveticaNeue-Bold"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .white
        scoreLabel.zPosition = 10
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height - 200 )
        //addChild(scoreLabel)
    }
    
    
    
    
}
