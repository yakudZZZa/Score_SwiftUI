//
//  PlayerCell.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct PlayerCell: View {
    //  @EnvironmentObject var playerStore: PlayerStore
    @State var player: Player
    @State var isSelected = false
    
    var body: some View {
        VStack(spacing: 0) {
            //      VStack(spacing: 0) {
            //        TransparentDivider()
            HStack{
                TextField("Input Name",
                          text: $player.name){ (selected) in
                    isSelected = selected
                } onCommit: {
                    print("Comitted")
                }
                .foregroundColor(.white)
                .padding()
                Spacer()
                
                HStack(spacing: 0) {
                    
                    ScoreButton(imageName: "minus", player: $player)
                    
                    Text("\(player.score)")
                        .foregroundColor(.white)
                        .frame(minWidth: 56)
                    
                    ScoreButton(imageName: "plus", player: $player)
                }
                //        }
                //        TransparentDivider()
            }
            .background(player.backgroundColor)
            
            if isSelected {
                ColorsView(selectedColorCell: $player.selectedColorIndex)
                //          .animation(.default)
            }
            
        }
        //    .background(player.backgroundColor)
        //    .animation(.default)
    }
}

struct PlayerCellPart_Previews: PreviewProvider {
    @State static var player = PlayerStore().players[3]
    //  @State static var background = Color.red
    static var previews: some View {
        PlayerCell(player: player)
    }
}

struct TransparentDivider: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .background(Color.black.opacity(0.1))
        
    }
}

struct ScoreButton: View {
    var imageName: String
    @Binding var player: Player
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
                .padding(.vertical)
        })
        .foregroundColor(.white)
    }
}
