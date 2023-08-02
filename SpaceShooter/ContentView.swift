//
//  ContentView.swift
//  SpaceShooter
//
//  Created by thaxz on 02/08/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    let scene = GameScene()
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
