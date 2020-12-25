//
//  TestView2.swift
//  Score
//
//  Created by Евгений Иванов on 17.12.2020.
//

import SwiftUI

//struct AnimatingCellHeight: AnimatableModifier {
//    var height: CGFloat?
//
//    var animatableData: CGFloat {
//      get { height ?? 0 }
//        set { height = newValue }
//    }
//
//    func body(content: Content) -> some View {
//        content.frame(height: height)
//    }
//}

struct SubView: View {
    @State var change: Bool = false

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 200)
                .foregroundColor(Color.red)
                .onTapGesture {
                    withAnimation {
                        self.change.toggle()
                    }
                }
            if change {
            Rectangle()
                .frame(width: 200)
                .foregroundColor(Color.blue)
            }
        }
        .modifier(AnimatingCellHeight(height: change ? 400 : 200))
        .listRowBackground(Color.black)
    }
}

struct TestView2: View {

    var body: some View {
        List {
            SubView()
            SubView()
        }
        .background(Color.black)
//        .listRowBackground(Color.black)
        
    }
}

struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
      TestView2()
    }
}
