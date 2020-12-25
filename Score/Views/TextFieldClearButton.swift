//
//  TextFieldClearButton.swift
//  Score
//
//  Created by Евгений Иванов on 23.12.2020.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    
    @Binding var text: String
    @Binding var isSelected: Bool
    
    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.init(white: 0.9))
                .opacity(isSelected && !text.isEmpty ? 1 : 0)
                .onTapGesture { self.text = "" }
        }
    }
}

struct TextFieldClearButton_Previews: PreviewProvider {
    @State static var text = "some text"
    @State static var isSelected = true
    static var previews: some View {
        TextField("placeholder", text: $text)
            .modifier(TextFieldClearButton(text: $text, isSelected: $isSelected))
            .background(Color.gray)
            .previewLayout(.sizeThatFits)
    }
}
