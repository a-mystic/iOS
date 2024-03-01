//
//  ContentView.swift
//  SingletonePattern
//
//  Created by a mystic on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var userManager = UserManager.shared
    
    var body: some View {
        VStack {
            DisplayNameView()
            SetNameView()
        }
    }
}

struct DisplayNameView: View {
    @ObservedObject private var userManager = UserManager.shared
    
    var body: some View {
        Text(userManager.user.name)
    }
}

struct SetNameView: View {
    @ObservedObject private var userManager = UserManager.shared
    
    var body: some View {
        Button("Set Username") {
            userManager.updateName("Changed username")
        }
    }
}

#Preview {
    ContentView()
}
