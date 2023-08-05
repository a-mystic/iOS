//
//  DesignForm.swift
//  testSpaceiOS
//
//  Created by a mystic on 2023/07/17.
//

import SwiftUI

struct DesignForm: View {
    @State private var str = ""
    let cont = bluetooth()
    
    var views: [some View] = [EmojiView()]
    
    var body: some View {
        views[0]
    }
}

struct EmojiView: View {
    var body: some View {
        Text("Emoji")
    }
    
    private func functionInFunction() {
        func inFunction() {
            
        }
        inFunction()
    }
}

struct DesignForm_Previews: PreviewProvider {
    static var previews: some View {
        DesignForm()
    }
}
