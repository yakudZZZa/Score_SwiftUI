//
//  ColorsView.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct ColorsView: View {
//    @EnvironmentObject var playerStore: PlayerStore
    
//    @Binding var player: Player
    @Binding var selectedColorIndex: Int
    @Binding var height: CGFloat?
//    var index: Int
    
    var body: some View {
        
        HStack(spacing: 0.0){
            ForEach(colors.indices) { colorIndex in
                ZStack{
                    Rectangle()
                        .frame(height: height)
                        .foregroundColor(Color(colors[colorIndex]))
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(self.selectedColorIndex == colorIndex ? Color.white : Color.clear)
                }
                .onTapGesture {
                    selectedColorIndex = colorIndex
                    //                    playerStore.save()
                }
            }
            .animation(.linear)
        }
    }
}

struct ColorsView_Previews: PreviewProvider {
    @State static var player = Player(score: 0, selectedColorIndex: 2)
    @State static var selectedColorIndex = 2
    @State static var height: CGFloat? = 45
    static var previews: some View {
        ColorsView(selectedColorIndex: $selectedColorIndex, height: $height)
            .previewLayout(.sizeThatFits)
    }
}
