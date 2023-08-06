//
//  MessagesViewModel.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import Foundation
import FirebaseFirestoreSwift

@MainActor
class MessagesViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    static let manager = MessagesViewModel()
    
    init() {
        self.isUserLoggedOut = FireBaseManager.manager.auth.currentUser?.uid == nil
        fetchCurrentUser()
        fetchRecentMessages()
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
    
    @Published var recentMessages = [RecentMessage]()
    
    private func fetchRecentMessages() {
        guard let uid = FireBaseManager.manager.auth.currentUser?.uid else { return }
        FireBaseManager.manager.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for recent messages: \(error)"
                    return
                }
                snapshot?.documentChanges.forEach({ documentSnapshot in
                    let documentId = documentSnapshot.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { $0.id == documentId }) {
                        self.recentMessages.remove(at: index)
                    }
                    do {
                        let rm = try documentSnapshot.document.data(as: RecentMessage.self)
                        self.recentMessages.insert(rm, at: 0)
                    } catch {
                        print(error)
                    }
//                    self.recentMessages.insert(RecentMessage(documentId: documentId, data: documentSnapshot.document.data()), at: 0)
                })
            }
    }
    
    @Published var isUserLoggedOut = false
    
    func signOut() {
        isUserLoggedOut.toggle()
        try? FireBaseManager.manager.auth.signOut()
    }
}
