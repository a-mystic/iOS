//
//  LoginView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/05.
//

import SwiftUI
import PhotosUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    selectLoginMode
                    profileImage
                    emailField
                    passwordField
                    createAccount
                    loginStatus
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Login" : "Create Account")
            .background(Color.gray.opacity(0.1))
        }
        .ignoresSafeArea(.all)
    }
    
    @State private var isLoginMode = false
    
    var selectLoginMode: some View {
        Picker(selection: $isLoginMode) {
            Text("Login")
                .tag(true)
            Text("Create Account")
                .tag(false)
        } label: {
            Text("Picker Here")
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    @State private var selectedImage: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    @ViewBuilder
    var profileImage: some View {
        if !isLoginMode {
            PhotosPicker(selection: $selectedImage, matching: .images, photoLibrary: .shared()) {
                if selectedImage != nil, let data = selectedImageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 128, height: 128)
                        .scaledToFill()
                        .cornerRadius(64)
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 64))
                        .padding()
                        .foregroundColor(Color(.label))
                        .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 1))
                }
            }
            .onChange(of: selectedImage) { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
    
    @State private var email = ""
    
    var emailField: some View {
        TextField("Email", text: $email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .padding(12)
            .background(Color.white)
            .cornerRadius(5)
    }
    
    @State private var password = ""
    
    var passwordField: some View {
        SecureField("PassWord", text: $password)
            .padding(12)
            .background(Color.white)
            .cornerRadius(5)
    }
    
    var createAccount: some View {
        Button {
            checkLoginMode()
        } label: {
            HStack {
                Spacer()
                Text(isLoginMode ? "LogIn" : "Create Account")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
            }
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
    
    private func checkLoginMode() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        FireBaseManager.manager.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user: ", err)
                loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            loginStatusMessage = "Successfully logged in user: \(result?.user.uid ?? "")"
        }
    }
    
    @State private var loginStatusMessage = ""
    
    var loginStatus: some View {
        Text(loginStatusMessage)
            .foregroundColor(.red)
    }
    
    private func createNewAccount() {
        FireBaseManager.manager.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user: ", err)
                loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            saveImageToStorage()
        }
    }
    
    private func saveImageToStorage() {
        let filename = UUID().uuidString
        guard let uid = FireBaseManager.manager.auth.currentUser?.uid else { return }
        let ref = FireBaseManager.manager.storage.reference(withPath: uid)
        guard let imageData = selectedImageData else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    loginStatusMessage = "Failed to retrieve image to downloadURL: \(err)"
                    return
                }
                loginStatusMessage = "Successfully store image with url: \(url?.absoluteString ?? "")"
                guard let url = url else { return }
                storeUserInformation(ProfileImageUrl: url)
            }
        }
    }
    
    private func storeUserInformation(ProfileImageUrl: URL) {
        guard let uid = FireBaseManager.manager.auth.currentUser?.uid else { return }
        let userData = [
            "email" : email,
            "uid" : uid,
            "profileImageUrl" : ProfileImageUrl.absoluteString
        ]
        FireBaseManager.manager.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    loginStatusMessage = "\(err)"
                    return
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
