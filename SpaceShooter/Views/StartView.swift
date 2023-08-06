//
//  StartView.swift
//  SpaceShooter
//
//  Created by thaxz on 06/08/23.
//

import SwiftUI
import SpriteKit

var shipChoice = UserDefaults.standard

struct StartView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                Image("background")
                    .aspectRatio(contentMode: .fill)
                VStack {
                    Spacer()
                    startButton
                    HStack {
                        
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
    }
}

// MARK: Components

extension StartView {
    
    var startButton: some View {
        NavigationLink {ContentView()} label: {
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 2)
                    )
                Text("Start Game")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
            }
            .frame(height: 50)
        }
    }
    
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
