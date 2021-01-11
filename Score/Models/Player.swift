//
//  Player.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

import SwiftUI

public let colors: [CGColor] = [#colorLiteral(red: 0.09019607843, green: 0.5176470588, blue: 0.262745098, alpha: 1),#colorLiteral(red: 0, green: 0.537254902, blue: 0.5058823529, alpha: 1),#colorLiteral(red: 0.2431372549, green: 0.5176470588, blue: 0.8039215686, alpha: 1),#colorLiteral(red: 0.3254901961, green: 0.3843137255, blue: 0.9254901961, alpha: 1),#colorLiteral(red: 0.6156862745, green: 0.2392156863, blue: 0.7137254902, alpha: 1),#colorLiteral(red: 0.7294117647, green: 0.1764705882, blue: 0.3607843137, alpha: 1),#colorLiteral(red: 0.8235294118, green: 0.2352941176, blue: 0.2352941176, alpha: 1),#colorLiteral(red: 0.8470588235, green: 0.4156862745, blue: 0.2274509804, alpha: 1),#colorLiteral(red: 0.9137254902, green: 0.6078431373, blue: 0.01960784314, alpha: 1),#colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1)]

struct Player: Identifiable, Codable, Hashable {
    
    var id = UUID()
    var name: String = ""
    var backgroundColor: Color {
        return Color(colors[selectedColorIndex])
    }
    var score: Int
    var selectedColorIndex: Int
}

