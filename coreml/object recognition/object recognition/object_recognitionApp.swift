//
//  object_recognitionApp.swift
//  object recognition
//
//  Created by mystic on 2022/05/17.
//

import SwiftUI

@main
struct object_recognitionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
