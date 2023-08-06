//
//  ChatLogView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct ChatLogView: View {
    let chatUser: ChatUser?
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                Text("")
            }
        }
        .navigationTitle(chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: nil)
    }
}
