//
//  ChatLogView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct ChatLogView: View {
    let chatUser: ChatUser?
    
    @ObservedObject private var viewModel: ChatLogViewModel
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.viewModel = ChatLogViewModel(chatUser: chatUser)
    }
    
    var body: some View {
        ZStack {
            messageBody
            Text(viewModel.errorMessage)
        }
            .navigationTitle(chatUser?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func isCurrentUser(_ user: ChatMessage) -> Bool {
        user.fromId == FireBaseManager.manager.auth.currentUser?.uid
    }
    
    var messageBody: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.chatMessages) { message in
                    VStack {
                        if isCurrentUser(message) {
                            textMessage(message.text, color: .black, position: .trailing)
                        } else {
                            textMessage(message.text, color: .white, position: .leading)
                        }
                    }
                }
                HStack { Spacer() }
            }
            .background(Color.gray.overlay(.regularMaterial))
            .safeAreaInset(edge: .bottom) { messageField }
        }
    }
    
    func textMessage(_ text: String, color: Color, position: MessagePosition) -> some View {
        HStack {
            if position == .trailing {
                Spacer()
            }
            Text(text).foregroundColor(color == .black ? .white : .black)
                .padding()
                .background(color)
                .cornerRadius(8)
            if position == .leading {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    enum MessagePosition {
        case leading
        case trailing
    }
    
    var messageField: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo").font(.system(size: 24)).foregroundColor(.black)
            TextField("message", text: $viewModel.chatText).textInputAutocapitalization(.never)
            send
        }
        .padding()
        .background(Color(.systemBackground).ignoresSafeArea())
    }
    
    var send: some View {
        Button {
            viewModel.send()
        } label: {
            Image(systemName: "paperplane.fill")
        }
        .padding(.horizontal)
        .buttonStyle(.borderedProminent)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MessagesView()
        }
    }
}
