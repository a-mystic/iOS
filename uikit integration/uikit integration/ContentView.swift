//
//  ContentView.swift
//  uikit integration
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct ContentView: View {
    @State private var pickedImage : Image? = nil
    @State private var isPickerpresented : Bool = false
    var body: some View {
        TabView{
            imagepickview
                .tabItem {
                    Text("1")
                }
            mapviewcall()
                .tabItem {
                    Text("2")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
    var imagepickview : some View {
        VStack{
            if let image = pickedImage{
                image
                    .resizable().scaledToFit()
                    .frame(width:300,height: 300)
                    .padding(.bottom)
            }
            Button {
                isPickerpresented.toggle()
            } label: {
                Text("show imagepicker")
            }
        }
        .sheet(isPresented: $isPickerpresented) {
                ImagePickerView(pickedImage: $pickedImage)
        }
    }
}
