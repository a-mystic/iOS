//
//  CoreDataTutorialApp.swift
//  CoreDataTutorial
//
//  Created by a mystic on 2023/06/23.
//

import SwiftUI

@main
struct CoreDataTutorialApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
