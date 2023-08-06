//
//  RecentMessage.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
//    var id: String { documentId }
//    let documentId: String
    @DocumentID var id: String?
    
    let text, fromId, toId: String
    let email, profileImageUrl: String
    let timestamp: Date
    
    
//    init(documentId: String, data: [String:Any]) {
//        self.documentId = documentId
//        self.text = data[FirebaseConstants.text] as? String ?? ""
//        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
//        self.toId = data[FirebaseConstants.toId] as? String ?? ""
//        self.profileImageUrl = data[FirebaseConstants.profileImageUrl] as? String ?? ""
//        self.email = data[FirebaseConstants.email] as? String ?? ""
//        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: .now)
//    }
}
