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
}
