//
//  Card.swift
//  gesture
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct Card : View {
    let size : CGSize = CGSize(width: 240, height: 200)
    let cornetradius : CGFloat = 14
    var body: some View {
        Image("b3")
            .frame(width: size.width, height: size.height)
            .cornerRadius(cornetradius)
    }
}
