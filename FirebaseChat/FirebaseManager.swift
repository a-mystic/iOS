//
//  FirebaseManager.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/05.
//

import Firebase
import FirebaseStorage

class FireBaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    
    static let manager = FireBaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        super.init()
    }
}
