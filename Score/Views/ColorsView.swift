//
//  ColorsView.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

struct ColorsView: View {
    
    @Binding var selectedColorCell: Int
    @Binding var height: CGFloat?
    
    var body: some View {
        
        ZStack {
            HStack(spacing: 0.0){
                ForEach(colors.indices) { index in
                    Button(action: {
                        print(index)
                        self.selectedColorCell = index
                    }) {
                        ZStack{
                            Rectangle()
                                .frame(height: height)
                                .foregroundColor(Color(colors[index]))
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(self.selectedColorCell == index ? Color.white : Color.clear)
                        }
                    }
                }
                .animation(.default)
            }
        }
    }
}

struct ColorsView_Previews: PreviewProvider {
    @State static var selectedColorCell = 0
    @State static var height: CGFloat? = 45
    static var previews: some View {
        ColorsView(selectedColorCell: $selectedColorCell, height: $height)
    }
}
