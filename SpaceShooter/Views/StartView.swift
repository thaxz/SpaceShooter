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
                VStack(spacing: 20){
                    Spacer()
                    startButton
                    HStack(spacing: 16){
                        PrimaryButton(action: {
                            makePlayerChoice(1)
                        }, name: "Ship 1")
                        PrimaryButton(action: {
                            makePlayerChoice(2)
                        }, name: "Ship 2")
                        PrimaryButton(action: {
                            makePlayerChoice(3)
                        }, name: "Ship 3")
                    }
                    .padding(.bottom, 50)
                }
            }
            .ignoresSafeArea()
        }
    }
    
    // todo: move to viewmodel
    func makePlayerChoice(_ choice: Int){
        shipChoice.set(choice, forKey: "playerChoice")
    }
    
}

// MARK: Components

extension StartView {
    
    var startButton: some View {
        NavigationLink {ContentView().navigationBarBackButtonHidden(true).navigationBarBackButtonHidden(true)} label: {
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.blue.opacity(0.3))
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
