//
//  GameOver.swift
//  SpaceShooter
//
//  Created by thaxz on 06/08/23.
//

import SwiftUI

// MARK: Appears if the player loses the game

struct GameOverView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.gray.opacity(0.5))
                .ignoresSafeArea()
            VStack(spacing: 8){
                Spacer()
                Text("DIZZY FLIGHT")
                    .font(.system(size: 42, weight: .heavy))
                    .foregroundColor(.white)
                Spacer()
                
                    Text("It looks like you got hit!")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    
                    Text("Try to not be hit!")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.white)
                
                Spacer()
               
                NavigationLink {
                    StartView()
                        .navigationBarBackButtonHidden(true).navigationBarBackButtonHidden(true)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color.black.opacity(0.3))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white, lineWidth: 2)
                            )
                        Text("Main Menu")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(height: 50)
                }

                
                
                Spacer()
                
                Spacer()
            }
            .multilineTextAlignment(.center)
        }
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            GameOverView()
            
        }
    }
}
