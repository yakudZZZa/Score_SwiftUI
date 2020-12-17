//
//  TransparentDivider.swift
//  Score
//
//  Created by Евгений Иванов on 17.12.2020.
//

import SwiftUI

struct TransparentDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .background(Color.clear)
            .foregroundColor(Color.black.opacity(0.1))
    }
}

struct TransparentDivider_Previews: PreviewProvider {
    static var previews: some View {
        TransparentDivider()
            .previewLayout(.sizeThatFits)
    }
}
