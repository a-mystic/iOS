//
//  MessagesView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct MessagesView: View {
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
        }
    }
    
    var chatList: some View {
        ForEach(0..<10, id: \.self) { number in
            VStack {
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .padding(8)
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.system(size: 16, weight: .bold))
                        Text("Message sent to user")
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    Text("22d")
                        .font(.system(size: 14, weight: .semibold))
                }
                Divider()
                    .padding(.vertical, 8)
            }
            .padding(.horizontal)
        }
    }
    
    var newMessage: some View {
        Button {
            
        } label: {
            Text("+")
                .scaleEffect(1.5)
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
