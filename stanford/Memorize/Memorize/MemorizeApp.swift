//
//  MemorizeApp.swift
//  Memorize
//
//  Created by mystic on 2022/07/06.
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
