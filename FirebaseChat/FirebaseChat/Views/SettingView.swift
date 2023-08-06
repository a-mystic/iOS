//
//  SettingView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject private var viewModel = MessagesViewModel.manager
    
    var body: some View {
        List {
            userStatus
            signOut
        }
        .fullScreenCover(isPresented: $viewModel.isUserLoggedOut) {
            LoginView {
                self.viewModel.isUserLoggedOut = false
                self.viewModel.fetchCurrentUser()
            }
        }
    }
    
    private var imageUrl: URL? {
        URL(string: viewModel.chatUser?.profileImageUrl ?? "")
    }
    
    var userStatus: some View {
        HStack(spacing: 16) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(50)
                    .shadow(radius: 3)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("\(viewModel.chatUser?.email ?? "")")
                    .font(.system(size: 24, weight: .bold))
            }
            Spacer()
        }
        .padding()
    }
    
    @State private var showSignOut = false
    
    var signOut: some View {
        Button("Sign Out", role: .destructive) {
            showSignOut.toggle()
        }
        .confirmationDialog("Settings", isPresented: $showSignOut) {
            Button("Sign Out", role: .destructive) {
                viewModel.signOut()
            }
        } message: {
            Text("What do you want to do?")
        }


    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
