//
//  MemorizeApp.swift
//  Memorize
//
//  Created by a mystic on 2023/07/03.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
