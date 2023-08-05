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
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            VStack {
                Text("hii")
                    .font(.headline).fontWeight(.bold)
                                   .padding().background(Color.white).cornerRadius(10)
                               .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4.0))
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
