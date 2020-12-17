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
        Rectangle()
            .frame(width: 200)
            .modifier(AnimatingCellHeight(height: change ? 300 : 200))
            .foregroundColor(Color.red)
            .onTapGesture {
                withAnimation {
                    self.change.toggle()
                }
        }
    }
}

struct TestView2: View {

    var body: some View {
        List {
            SubView()
            SubView()
        }
    }
}

struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
      TestView2()
    }
}
