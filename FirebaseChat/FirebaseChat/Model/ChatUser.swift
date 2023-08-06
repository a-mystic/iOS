//
//  ChatUser.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import Foundation

struct ChatUser: Identifiable {
    var id: String { uid }
    let uid, email, profileImageUrl: String
    
    init(data: [String:Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = (data["email"] as? String ?? "").replacingOccurrences(of: "@gmail.com", with: "")
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
