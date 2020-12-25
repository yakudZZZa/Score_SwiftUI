//
//  ScoreApp.swift
//  Score
//
//  Created by Евгений Иванов on 04.12.2020.
//

import SwiftUI

@main
struct ScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PlayerStore())
        }
    }
}
