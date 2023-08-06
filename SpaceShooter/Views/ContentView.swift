//
//  ContentView.swift
//  SpaceShooter
//
//  Created by thaxz on 02/08/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View, GameLogicDelegate {
    
    // trying to pass data by delegate
    @State var totalScore: Int = 0
    @State var isGameOver: Bool = false
    
    mutating func addPoint() {
        self.totalScore += 1
    }
    
    mutating func passGameOver() {
        self.isGameOver.toggle()
    }
    
    var gameScene: GameScene {
        let scene = GameScene()
        scene.scaleMode = .fill
        scene.gameLogicDelegate = self
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: gameScene)
                .ignoresSafeArea()
            VStack {
                Text("Score: \(self.totalScore)")
                    .font(.title).fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                if isGameOver {
                    // ADD GAME OVER VIEW
                    Circle().fill(.red)
                }
                Spacer()
            }
            // add gameover sheet
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
