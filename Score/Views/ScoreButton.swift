//
//  ScoreButton.swift
//  Score
//
//  Created by Евгений Иванов on 17.12.2020.
//

import SwiftUI

struct ScoreButton: View {
    var imageName: String
    @Binding var player: Player
    @Binding var height: CGFloat?
    var body: some View {
        Button(action: {
            switch imageName {
            case "plus":
                player.score += 1
            case "minus":
                player.score -= 1
            default: break
            }
        }, label: {
            Image(systemName: "\(imageName)")
                .padding(.horizontal, 15)
                .frame(height: height)
        })
        .foregroundColor(.white)
    }
}

struct ScoreButton_Previews: PreviewProvider {
    @State static var player = Player(score: 0, selectedColorIndex: 1)
    @State static var height: CGFloat? = 45
    static var previews: some View {
        ScoreButton(imageName: "plus", player: $player, height: $height)
            .background(Color.black)
    }
}
