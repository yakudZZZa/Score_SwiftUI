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
    @EnvironmentObject var playerStore: PlayerStore
    
    private struct SizeKey: PreferenceKey {
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }
    var index: Int
    @State var name: String
    @State var score: Int
    @State var selectedColorIndex: Int
    @State var backgroundColor: Color
    @State var isSelected = false
    @State private var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                TextField("Input Name",
                          text: $name)
                { (selected) in
                    withAnimation(.linear) {
                        isSelected = selected
                    }
                } onCommit: {
                    self.playerStore.players[index].name = self.name
                }
                .disableAutocorrection(true)
                .autocapitalization(.words)
                .foregroundColor(.white)
                .padding()
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizeKey.self, value: proxy.size
                        )
                    }
                )
                .modifier(TextFieldClearButton(
                    text: $name,
                    isSelected: $isSelected
                ))
                HStack(spacing: 0) {
                    ScoreButton(
                        imageName: .minus,
                        index: index,
                        height: $height
                    )
                    
                    Text("\(score)")
                        .foregroundColor(.white)
                        .frame(height: height)
                        .frame(minWidth: 56)
                    
                    ScoreButton(
                        imageName: .plus,
                        index: index,
                        height: $height
                    )
                }
            }
            .frame(height: height)
            .background(backgroundColor)
            .animation(.linear)
            .onPreferenceChange(SizeKey.self) { size in
                self.height = size?.height
            }
            
            if isSelected {
                ColorsView(
                    selectedColorCell: $selectedColorIndex,
                    height: $height,
                    index: index
                )
//                .zIndex(-1)
//                .transition(
//                    .offset(y: -(height!))
//                )
            }
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.mainBackgroundColor)
        .modifier(AnimatingCellHeight(height: isSelected ? 2 * height! : height ))
    }
}

//struct PlayerCellPart_Previews: PreviewProvider {
//    @State static var player = PlayerStore().players[3]
//    static var previews: some View {
//        PlayerCell(index: 3)
//            .environmentObject(PlayerStore())
//            .previewLayout(.sizeThatFits)
//    }
//}
