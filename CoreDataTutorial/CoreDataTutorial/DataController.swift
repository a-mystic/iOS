//
//  DataController.swift
//  CoreDataTutorial
//
//  Created by a mystic on 2023/06/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BookModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
    }
}
