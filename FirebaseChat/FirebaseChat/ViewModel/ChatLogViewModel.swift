//
//  ChatLogViewModel.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        fetchMessages()
    }
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    func send() {
        guard let fromId = FireBaseManager.manager.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        let document = FireBaseManager.manager.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        let messageData = [
            FirebaseConstants.fromId : fromId,
            FirebaseConstants.toId : toId,
            FirebaseConstants.text : self.chatText,
            "timestamp" : Timestamp()
        ] as [String : Any]
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into FireStore: \(error)"
                return
            }
            self.chatText = ""
        }
        let recipientMessageDocument = FireBaseManager.manager.firestore
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into FireStore: \(error)"
                return
            }
        }
    }
    
    @Published var chatMessages = [ChatMessage]()
    
    private func fetchMessages() {
        guard let fromId = FireBaseManager.manager.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        FireBaseManager.manager.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(ChatMessage(documentId: change.document.documentID, data: data))
                    }
                })
//                snapshot?.documents.forEach({ documentSnapshot in
//                    let data = documentSnapshot.data()
//                    let documentId = documentSnapshot.documentID
//                    self.chatMessages.append(ChatMessage(documentId: documentId, data: data))
//                })
            }
    }
}
