//
//  admobApp.swift
//  admob
//
//  Created by mystic on 2022/05/26.
//

import SwiftUI
import GoogleMobileAds

@main
struct admobApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
