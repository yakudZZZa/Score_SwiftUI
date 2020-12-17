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
    @State var player: Player
    @State var isSelected = false
    @State private var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                TextField("Input Name",
                          text: $player.name)
                { (selected) in
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
                
                HStack(spacing: 0) {
                    ScoreButton(
                        imageName: "minus",
                        player: $player,
                        height: $height
                    )
                    
                    Text("\(player.score)")
                        .foregroundColor(.white)
                        .frame(height: height)
                        .frame(minWidth: 56)
                    
                    ScoreButton(
                        imageName: "plus",
                        player: $player,
                        height: $height
                    )
                }
            }
            .frame(height: height)
            .background(player.backgroundColor)
            .onPreferenceChange(SizeKey.self) { size in
                self.height = size?.height
            }
            
            if isSelected {
                ColorsView(
                    selectedColorCell: $player.selectedColorIndex,
                    height: $height
                )
                .zIndex(-1)
                .transition(
                    .offset(y: -(height!))
                )
            }
        }
        .modifier(AnimatingCellHeight(height: isSelected ? 2 * height! : height ))
    }
}

struct PlayerCellPart_Previews: PreviewProvider {
    @State static var player = PlayerStore().players[3]
    static var previews: some View {
        PlayerCell(player: player)
            .previewLayout(.sizeThatFits)
    }
}
