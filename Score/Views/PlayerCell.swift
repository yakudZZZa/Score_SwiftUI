//
//  PlayerCell.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat?
    
    var animatableData: CGFloat {
        get { height ?? 0 }
        set { height = newValue }
    }
    
    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}

struct PlayerCell: View {
    private struct SizeKey: PreferenceKey {
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }
    //  @EnvironmentObject var playerStore: PlayerStore
    @State var player: Player
    @State var isSelected = false
    @State private var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 0) {
            //      VStack(spacing: 0) {
            //        TransparentDivider()
            HStack{
                TextField("Input Name",
                          text: $player.name){ (selected) in
                    withAnimation(.linear) {
                        isSelected = selected
                    }
                } onCommit: {
                    print("Comitted")
                }
                .foregroundColor(.white)
                .padding()
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizeKey.self, value: proxy.size
                        )
                    }
                )
                //                Spacer()
                
                HStack(spacing: 0) {
                    
                    ScoreButton(imageName: "minus", player: $player, height: $height)
                    
                    Text("\(player.score)")
                        .foregroundColor(.white)
                        .frame(height: height)
                        .frame(minWidth: 56)
                    
                    ScoreButton(imageName: "plus", player: $player, height: $height)
                }
                //        }
                //        TransparentDivider()
            }
            .frame(height: height)
            .background(player.backgroundColor)
            .onPreferenceChange(SizeKey.self) { size in
                self.height = size?.height
            }
            
            if isSelected {
                ColorsView(selectedColorCell: $player.selectedColorIndex, height: $height)
                    .zIndex(-1)
                    .transition(
                        .offset(y: -(height!))
                    )
//                    .transition(.offset(y: -(height! / 2)))
//                    .animation(.linear)
            }
            
        }
        .modifier(AnimatingCellHeight(height: isSelected ? 2 * height! : height ))
        //    .background(player.backgroundColor)
        //    .animation(.default)
    }
}

struct PlayerCellPart_Previews: PreviewProvider {
    @State static var player = PlayerStore().players[3]
    //  @State static var background = Color.red
    static var previews: some View {
        PlayerCell(player: player)
            .previewLayout(.sizeThatFits)
    }
}

struct TransparentDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .background(Color.clear)
            .foregroundColor(Color.black.opacity(0.1))
        
    }
}

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
