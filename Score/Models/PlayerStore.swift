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
    @Published var players: [Player] = []
    
    init() {
        if players.isEmpty {
            self.load()
            if players.isEmpty {
                self.setPlayers()
            }
        }
    }
    
    func getIndex(of player: Player) -> Int {
        return self.players.firstIndex(where: {$0.id == player.id})!
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(players) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
            print("Data saved")
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Player].self, from: data) {
                self.players = decoded
            }
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
    
    func getBackgroundColor(id: UUID) -> Color {
        return self.players[self.players.firstIndex(where: {$0.id == id})!].backgroundColor
    }
    
    func addNewPlayer() {
        self.players.append(Player(name: "Player \(self.players.count + 1)", score: 0, selectedColorIndex: chooseRandomColorIndex()))
        save()
        print("saved after add player")
    }
    
    func deletePlayer(offsets: IndexSet) {
        self.players.remove(atOffsets: offsets)
        save()
        print("saved after delete")
        print(players)
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int) {
        self.players.move(fromOffsets: fromOffsets, toOffset: toOffset)
        save()
    }
    
    func update() {
        self.objectWillChange.send()
    }
    
    
}
