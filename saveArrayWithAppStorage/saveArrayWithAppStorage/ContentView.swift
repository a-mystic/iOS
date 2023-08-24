//
//  ContentView.swift
//  saveArrayWithAppStorage
//
//  Created by a mystic on 2023/08/07.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("items") private var items: [String] = []
    @AppStorage("count") private var count = 0
    @AppStorage("constructs") private var const: [Constructs] = []

    var body: some View {
        VStack {
            Text("items: \(String(describing: items))")
            Button("Add item") {
                count += 1
                items.append(String(count))
            }
        }
    }
}

struct Constructs: Codable {
    let color: String
    let image: String
}

extension Array: RawRepresentable where Element: Codable { // Element: Codable is important.
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
