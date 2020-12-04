//
//  PlayerStore.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import Foundation
import SwiftUI
import Combine

class PlayerStore: ObservableObject {
    
    var choosedColorsIndexes: [Int] = colors.indices.map{ $0 }
    //  static let colors: [Color] = [
    //    Color(red: 23, green: 132, blue: 67),
    //    Color(red: 0, green: 137, blue: 129),
    //    Color(red: 62, green: 132, blue: 205),
    //    Color(red: 83, green: 98, blue: 236),
    //    Color(red: 157, green: 61, blue: 182),
    //    Color(red: 186, green: 45, blue: 92),
    //    Color(red: 210, green: 60, blue: 60),
    //    Color(red: 216, green: 106, blue: 58),
    //    Color(red: 233, green: 155, blue: 5),
    //    Color(red: 103, green: 103, blue: 103)
    //  ]
    
    @Published var players: [Player] = []
    
    init(players: [Player] = []) {
        if players.isEmpty{
            setPlayers()
        }
    }
    
    func chooseRandomColorIndex() -> Int {
        if !choosedColorsIndexes.isEmpty {
            let tempIndex = choosedColorsIndexes.randomElement()!
            choosedColorsIndexes = choosedColorsIndexes.filter { $0 != tempIndex }
            return tempIndex
        } else {
            return Int.random(in: 0..<colors.count)
        }
    }
    
    func setPlayers() {
        self.players.append(Player(score: 0, selectedColorIndex: chooseRandomColorIndex()))
        self.players.append(Player(name: "Александра", score: 0, selectedColorIndex: chooseRandomColorIndex()))
        self.players.append(Player(name: "Евгений", score: 0, selectedColorIndex: chooseRandomColorIndex()))
        self.players.append(Player(name: "Алиса", score: 0, selectedColorIndex: chooseRandomColorIndex()))
        self.players.append(Player(name: "Сергей", score: 0, selectedColorIndex: chooseRandomColorIndex()))
    }
    
    func bindingName(for index: Int) -> Binding<String> {
        Binding(
            get: { self.players[index].name },
            set: { self.players[index].name = $0 }
        )
    }
    
    func bindingValue(for index: Int) -> Binding<Int> {
        Binding(
            get: { self.players[index].score },
            set: { self.players[index].score = $0 }
        )
    }
    
    func addNewPlayer() {
        self.players.append(Player(score: 0, selectedColorIndex: chooseRandomColorIndex()))
    }
    //  func addPlayer() {
    //    players.append(Player(backgroundColor: PlayerStore.colors.randomElement()!))
    //  }
    //
    //  static func getRandomColor() -> CGColor {
    //    guard let randomElement = self.colors.randomElement() else { fatalError() }
    //    return randomElement
    //  }
}

//var testData: [Player] = [
//    Player(backgroundColor: colors.randomElement()!),
//    Player(name: "Александра", backgroundColor: colors.randomElement()!),
//    Player(name: "Евгений", backgroundColor: colors.randomElement()!),
//    Player(name: "Алиса", backgroundColor: colors.randomElement()!),
//    Player(name: "Сергей", backgroundColor: colors.randomElement()!)
//]
