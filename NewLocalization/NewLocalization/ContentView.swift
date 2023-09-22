//
//  ContentView.swift
//  NewLocalization
//
//  Created by a mystic on 2023/09/20.
//

import SwiftUI

struct ContentView: View {
    private let localizedString: LocalizedStringKey = "Hello"
    @State private var state: States = .one
    
    enum States {
        case one
        case two
        
        var status: LocalizedStringKey {
            switch self {
            case .one:
                return "one"
            case .two:
                return "two"
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(localizedString)
            Text(state.status)
            Button("change") {
                state = .two
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
