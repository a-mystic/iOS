//
//  modifier.swift
//  SwiftUI need
//
//  Created by mystic on 2022/06/18.
//

import SwiftUI

struct modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(.white)
            .border(.gray,width: 12)
            .shadow(color:.black,radius: 5,x:0,y:5)
    }
}
