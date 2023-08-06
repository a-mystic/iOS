//
//  NewMessageView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = NewMessageViewModel()
    
    let selectNewUser: (ChatUser) -> ()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(viewModel.errorMessage)
                ForEach(viewModel.users) { user in
                    createOtherUser(user)
                    Divider().padding(.vertical, 8)
                }
            }
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancel
                }
            }
        }
    }
    
    func createOtherUser(_ user: ChatUser) -> some View {
        Button {
            dismiss.callAsFunction()
            selectNewUser(user)
        } label: {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: user.profileImageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(50)
                } placeholder: {
                    ProgressView()
                }
                Text(user.email).foregroundColor(Color(.label))
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    var cancel: some View {
        Button("Cancel") {
            dismiss.callAsFunction()
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
