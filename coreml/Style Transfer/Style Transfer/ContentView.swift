//
//  ContentView.swift
//  Style Transfer
//
//  Created by mystic on 2022/07/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TransferView()
//        boximageView()
    }
}

struct boximageView: View {
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    var body: some View {
        ZStack {
            Button {
                imagePickerPresented.toggle()
            } label: {
                Rectangle()
                    .stroke()
                    .frame(width:200,height:200)
            } .sheet(isPresented: $imagePickerPresented,
                     onDismiss: loadImage,
                     content: { ImagePickerView(Bindingimage: $selectedImage)})
            if let image = profileImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipped()
            }
        }
        .foregroundColor(.black)
        .preferredColorScheme(.light)
    }
    
    func loadImage() {
            guard let selectedImage = selectedImage else { return }
            profileImage = Image(uiImage: selectedImage)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
