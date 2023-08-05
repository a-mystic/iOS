//
//  CoreDataTutorial2App.swift
//  CoreDataTutorial2
//
//  Created by a mystic on 2023/07/12.
//

import SwiftUI

@main
struct CoreDataTutorial2App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
