//
//  MainView.swift
//  FirebaseChat
//
//  Created by a mystic on 2023/08/06.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MessagesView()
                .tabItem {
                    Image(systemName: "house")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
