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
    
    mutating func addPoint() {
        self.totalScore += 1
    }
    
    var gameScene: GameScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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
                    
                Spacer()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
