//
//  admobspmApp.swift
//  admobspm
//
//  Created by mystic on 2022/07/26.
//

import SwiftUI
import GoogleMobileAds

@main
struct admobspmApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
