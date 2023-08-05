//
//  Viewbuilder.swift
//  SwiftUI need
//
//  Created by mystic on 2022/06/18.
//

import SwiftUI

struct mystack<Content: View>: View {
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content){
        self.content = content
    }
    var body: some View{
        VStack(spacing:10){
            content()
        }
        .font(.largeTitle)
    }
}
