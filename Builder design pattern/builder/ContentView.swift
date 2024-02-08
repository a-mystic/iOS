//
//  ContentView.swift
//  builder
//
//  Created by a mystic on 2/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Make Builder") {
            let builder = Builder()
                .setBaseUrl("naver.com")
                .setCallMethod()
            builder.printAll()
        }
    }
}

class Builder {
    private var baseUrl = ""
    private var method = ""
    
    func setBaseUrl(_ url: String) -> Self {
        self.baseUrl = url
        return self
    }
    
    func setCallMethod(_ method: String = "Get") -> Self {
        self.method = method
        return self
    }
    
    func printAll() {
        print(baseUrl, method)
    }
}

#Preview {
    ContentView()
}
