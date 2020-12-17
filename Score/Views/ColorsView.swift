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
//                    .background(Color(colors[index]))
                }
                .animation(.default)
            }
            //      VStack{
            //        TransparentDivider()
            //        Spacer()
            //          .frame(maxHeight: 43)
            //        TransparentDivider()
            //      }
        }
    }
}

struct ColorsViewTemp: View {
    
    let circleSize: CGFloat = 10
    @Binding var selectedColorCell: Int
    @State private var frames = Array<CGRect>(repeating: .zero, count: colors.count)
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            HStack(spacing: 0.0){
                ForEach(colors.indices) { index in
                    Button(action: {
                        print(index)
                        self.selectedColorCell = index
                    }) {
                        Rectangle()
                            .frame(height: 45, alignment: .center)
                            .foregroundColor(.clear)
                        //            .fixedSize(horizontal: false, vertical: true)
                        //            .frame(height: 45, alignment: .center)
                    }
                    .background(
                        GeometryReader(content: { geometry in
                            Rectangle()
                                .fill(Color(colors[index]))
                                //                .frame(height: 45, alignment: .top)
                                .onAppear{
                                    self.setFrame(index: index, frame: geometry.frame(in: .global))
                                    print(geometry.frame(in: .global))
                                }
                        })
                    )
                }
                //        .animation(.default)
            }
            Circle()
                .frame(width: circleSize, height: circleSize, alignment: .center)
                .foregroundColor(Color.white.opacity(0.8))
                .offset(x: self.frames[self.selectedColorCell].midX - circleSize / 2)
            //        .offset(x: 0)
        }
        .animation(.default)
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}


struct ColorsView_Previews: PreviewProvider {
    @State static var selectedColorCell = 0
    @State static var height: CGFloat? = 45
    static var previews: some View {
        ColorsView(selectedColorCell: $selectedColorCell, height: $height)
        //        ColorsViewTemp(selectedColorCell: $selectedColorCell)
    }
}
