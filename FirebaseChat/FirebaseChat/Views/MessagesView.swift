//
//  MessagesView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct MessagesView: View {
    @ObservedObject private var viewModel = MessagesViewModel.manager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                chatList
            }
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    newMessage
                }
            }
            .navigationDestination(isPresented: $showChatLogView) {
                ChatLogView(chatUser: self.chatUser)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isUserLoggedOut) {
            LoginView {
                self.viewModel.isUserLoggedOut = false
                self.viewModel.fetchCurrentUser()
            }
        }
    }
    
    var chatList: some View {
        ForEach(viewModel.recentMessages) { message in
            VStack {
                NavigationLink {
                    let data = [
                        "uid" : message.id ?? "",
                        "email" : message.email,
                        "profileImageUrl" : message.profileImageUrl
                    ] as [String:Any]
                    ChatLogView(chatUser: ChatUser(data: data))
                } label: {
                    HStack(spacing: 16) {
                        profileImage(message)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(message.email)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(.label))
                            Text(message.text)
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
//                        let timeInterval = message.timestamp.timeIntervalSinceNow.description
                        Text(message.timestamp.description).font(.system(size: 14, weight: .semibold))
                    }
                }
                Divider().padding(.vertical, 8)
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func profileImage(_ message: RecentMessage) -> some View {
        let url = URL(string: message.profileImageUrl)
        AsyncImage(url: url, content: { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipped()
                .cornerRadius(64)
                .shadow(radius: 2)
        }, placeholder: {
            ProgressView()
        })
    }
    
    @State private var showNewMessage = false
    @State private var showChatLogView = false

    var newMessage: some View {
        Button {
            showNewMessage.toggle()
        } label: {
            Text("+")
                .scaleEffect(1.5)
        }
        .sheet(isPresented: $showNewMessage) {
            NewMessageView { user in
                self.showChatLogView.toggle()
                self.chatUser = user
            }
        }
    }
    
    @State var chatUser: ChatUser?
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
