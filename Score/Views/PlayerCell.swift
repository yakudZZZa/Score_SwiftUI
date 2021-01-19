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
        content.frame(height: height, alignment: .top)
    }
}

struct PlayerCell: View {
    @EnvironmentObject var playerStore: PlayerStore
    
    private struct SizeKey: PreferenceKey {
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }
    @ObservedObject var player: Player
//    var playerIndex: Int {
//        return playerStore.players.firstIndex(where: {$0.id == player.id})!
//    }
    @State var isSelected = false
    @State private var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0){
                TextField("Input Name",
                          text: $player.name)
                { (selected) in
//                    withAnimation(.default) {
                        isSelected = selected
//                    }
                } onCommit: {
//                    playerStore.save()
                }
                .disableAutocorrection(true)
                .autocapitalization(.words)
                .foregroundColor(.white)
                .padding(.vertical)
                .padding(.leading)
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizeKey.self, value: proxy.size
                        )
                    }
                )
                .modifier(TextFieldClearButton(
                    text: $player.name,
                    isSelected: $isSelected
                ))
                HStack(spacing: 0) {
                    ScoreButton(
                        imageName: .minus,
                        score: $player.score,
                        height: $height
                    )
                    
                    Text("\($player.score.wrappedValue)")
                        .foregroundColor(.white)
                        .frame(height: height)
                        .frame(minWidth: 56)
                    
                    ScoreButton(
                        imageName: .plus,
                        score: $player.score,
                        height: $height
                    )
                }
            }
            .frame(height: height)
            .background(player.backgroundColor)
//            .animation(.linear)
            .onPreferenceChange(SizeKey.self) { size in
                self.height = size?.height
            }
            
//            if isSelected {
//                ColorsView(
//                    selectedColorIndex: $player.selectedColorIndex,
//                    height: $height
//                )
//                .zIndex(-10)
//                .offset(y: isSelected ? 0 : -(height ?? 0))
//                .opacity(isSelected ? 1 : 0)
//                .frame(height: isSelected ? height : 0)
//                .transition(
//                    .offset(y: -(height!))
//                )
//            }
        }
        .id(player.id)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.mainBackgroundColor)
        .modifier(AnimatingCellHeight(height: isSelected ? 2 * height! : height ))
//        .animation(.linear)
    }
}

struct PlayerCellPart_Previews: PreviewProvider {
    @State static var player = Player(name: "Евгений", score: 12, selectedColorIndex: 3)
    static var previews: some View {
        PlayerCell1(player: player)
            .environmentObject(PlayerStore())
            .previewLayout(.sizeThatFits)
    }
}

struct PlayerCell1: View {
    @EnvironmentObject var playerStore: PlayerStore
    
    private struct SizeKey: PreferenceKey {
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }
    @ObservedObject var player: Player
//    var playerIndex: Int {
//        return playerStore.players.firstIndex(where: {$0.id == player.id})!
//    }
    @State var isSelected = false
//    @State private var height: CGFloat?
    @State private var height: CGFloat? = 45
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0){
                TextField("Input Name",
                          text: $player.name)
                { (selected) in
//                    withAnimation(.linear) {
                        isSelected = selected
//                    }
                } onCommit: {
//                    playerStore.save()
                }
                .disableAutocorrection(true)
                .autocapitalization(.words)
                .foregroundColor(.white)
                .padding(.vertical)
                .padding(.leading)
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizeKey.self, value: proxy.size
                        )
                    }
                )
                .modifier(TextFieldClearButton(
                    text: $player.name,
                    isSelected: $isSelected
                ))
                HStack(spacing: 0) {
                    ScoreButton(
                        imageName: .minus,
                        score: $player.score,
                        height: $height
                    )
                    
                    Text("\($player.score.wrappedValue)")
                        .foregroundColor(.white)
                        .frame(height: height)
                        .frame(minWidth: 56)
                    
                    ScoreButton(
                        imageName: .plus,
                        score: $player.score,
                        height: $height
                    )
                }
            }
//            .frame(height: height)
            .background(player.backgroundColor)
//            .animation(.linear)
//            .onPreferenceChange(SizeKey.self) { size in
//                self.height = size?.height
//            }
            
            if isSelected {
                ColorsView(
                    selectedColorIndex: $player.selectedColorIndex,
                    height: $height
                )
//                .zIndex(-10)
//                .offset(y: isSelected ? 0 : -(height ?? 0))
//                .opacity(isSelected ? 1 : 0)
//                .frame(height: isSelected ? height : 0)
//                .transition(
//                    .offset(y: -(height!))
//                )
            }
        }
        .id(player.id)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
//        .modifier(AnimatingCellHeight(height: isSelected ? 2 * height! : height ))
//        .animation(.default)
    }
}
