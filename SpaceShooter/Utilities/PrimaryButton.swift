//
//  PrimaryButton.swift
//  SpaceShooter
//
//  Created by thaxz on 06/08/23.
//

import SwiftUI

struct PrimaryButton: View {
    let action: () -> Void
    let name: String
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 2)
                    )
                Text(name)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
            }
            .frame(height: 50)
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(action: {}, name: "hi")
    }
}
