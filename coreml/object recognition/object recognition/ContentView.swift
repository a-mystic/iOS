//
//  ContentView.swift
//  object recognition
//
//  Created by mystic on 2022/05/17.
//

import SwiftUI

struct ContentView: View {
    @State private var ispresent : Bool = false
    @State var uiImage: UIImage?
    
    @ObservedObject var classifier : ImageClassifier
    
    var body: some View {
        VStack{
            Image(systemName: "photo")
                .foregroundColor(.white)
                .onTapGesture {
                    ispresent = true
                }
            if uiImage != nil {
                Image(uiImage: uiImage!)
                    .resizable()
                    .scaledToFit()
            }
            Button {
                if uiImage != nil{
                    classifier.detect(uiImage: uiImage!)
                }
            } label: {
                Image(systemName: "bolt.fill")
            }
            if let imageclass = classifier.imageclass{
                Text(imageclass)
            }
            else{
                Text("not")
            }

        
        }
        .sheet(isPresented: $ispresent){
            imagepicker(uiImage: $uiImage, ispresenting: $ispresent)
        }
        .preferredColorScheme(.dark)
    }
}


