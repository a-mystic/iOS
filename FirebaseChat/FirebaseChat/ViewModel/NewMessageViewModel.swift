//
//  NewMessageViewModel.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        FireBaseManager.manager.firestore.collection("users")
            .getDocuments { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    return
                }
                snapshot?.documents.forEach({ document in
//                    if document.data()["uid"] != FireBaseManager.manager.auth.currentUser?.uid {
//
//                    }
                    self.users.append(ChatUser(data: document.data()))
                })
            }
    }
}
