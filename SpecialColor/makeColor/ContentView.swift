//
//  ContentView.swift
//  makeColor
//
//  Created by a mystic on 2023/09/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        specialGold
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private var specialGold: some View {
        Color.brown.opacity(0.4)
            .overlay(Color.yellow.opacity(0.1).gradient)
    }
}

#Preview {
    ContentView()
}
