//
//  MessagesViewModel.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import Foundation

@MainActor
class MessagesViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        self.isUserLoggedOut = FireBaseManager.manager.auth.currentUser?.uid == nil
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FireBaseManager.manager.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        FireBaseManager.manager.firestore.collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current User:  \(error)"
                    return
                }
                guard let data = snapshot?.data() else {
                    self.errorMessage = "No data found"
                    return
                }
                self.chatUser = ChatUser(data: data)
            }
    }
    
    @Published var isUserLoggedOut = false
    
    func signOut() {
        isUserLoggedOut.toggle()
        try? FireBaseManager.manager.auth.signOut()
    }
}
