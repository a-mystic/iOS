//
//  ContentView.swift
//  Image Picker
//
//  Created by mystic on 2022/05/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            UIImagePickerControllerContentView()
                .tabItem {
                    Image(systemName: "house")
                }
            PHPickerViewControllerContentView()
                .tabItem {
                    Image(systemName: "pencil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
