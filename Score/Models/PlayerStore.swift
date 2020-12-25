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
    
    private static let saveKey = "SavedData"
    var choosedColorsIndexes: [Int] = colors.indices.map{ $0 }
    
    @Published var players: [Player]
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Player].self, from: data) {
                self.players = decoded
                return
            }
        }
        self.players = []
        self.setPlayers()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
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
            set: { newName in
                self.players[index].name = newName.trimmingCharacters(in: .whitespacesAndNewlines)
                self.save()
            }
        )
    }
    
    func bindingScore(for index: Int) -> Binding<Int> {
        Binding(
            get: { self.players[index].score },
            set: { newScore in
                self.players[index].score = newScore
                self.save()
            }
        )
    }
    
    func bindingColor(for index: Int) -> Binding<Int> {
        Binding(
            get: { self.players[index].selectedColorIndex },
            set: { newColorIndex in
                self.players[index].selectedColorIndex = newColorIndex
                self.save()
            }
        )
    }
    
    func addNewPlayer() {
        self.players.append(Player(score: 0, selectedColorIndex: chooseRandomColorIndex()))
        save()
    }
    
    func deletePlayer(offsets: IndexSet) {
        self.players.remove(atOffsets: offsets)
        save()
    }
}
