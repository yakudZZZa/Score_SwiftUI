//
//  ScoreButton.swift
//  Score
//
//  Created by Евгений Иванов on 17.12.2020.
//

import SwiftUI

struct ScoreButton: View {
    @EnvironmentObject var playerStore: PlayerStore
    enum name {
        case plus, minus
    }
    var imageName: name
    var index: Int
//    @Binding var score: Int
    @Binding var height: CGFloat?
    var body: some View {
        Button(action: {
            switch imageName {
            case .plus:
                playerStore.players[index].score += 1
                playerStore.save()
            case .minus:
                playerStore.players[index].score -= 1
                playerStore.save()
            }
        }, label: {
            Image(systemName: "\(imageName)")
                .padding(.horizontal, 15)
                .frame(height: height)
        })
        .foregroundColor(.white)
    }
}

//struct ScoreButton_Previews: PreviewProvider {
//    @State static var score = 0
//    @State static var height: CGFloat? = 45
//    static var previews: some View {
//        ScoreButton(imageName: .plus, score: $score, height: $height)
//            .background(Color.black)
//            .previewLayout(.sizeThatFits)
//    }
//}
