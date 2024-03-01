//
//  User.swift
//  SingletonePattern
//
//  Created by a mystic on 3/2/24.
//

import Foundation

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @Published var user = User(name: "", age: 0)
    
    func updateName(_ name: String) {
        self.user.updateName(name)
    }
    
    func updateAge(_ age: Int) {
        self.user.updateAge(age)
    }
}

struct User {
    var name: String
    var age: Int
    
    mutating func updateName(_ name: String) {
        self.name = name
    }
    
    mutating func updateAge(_ age: Int) {
        self.age = age
    }
}
