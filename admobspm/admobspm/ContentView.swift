//
//  ContentView.swift
//  admobspm
//
//  Created by mystic on 2022/07/26.
//
//-ObjC link must edit

import SwiftUI

struct ContentView: View {
    let bannerID = "ca-app-pub-3940256099942544/2934735716"
    
    var body: some View {
            BannerAd(unitID: bannerID)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
