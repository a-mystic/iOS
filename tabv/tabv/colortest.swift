//
//  colortest.swift
//  tabv
//
//  Created by mystic on 2022/04/04.
//

import SwiftUI

struct colortest: View {
    var body: some View {
        ZStack{
            Color("customdark")
                .edgesIgnoringSafeArea(.all)
            Text("test")
        }
    }
}

struct colortest_Previews: PreviewProvider {
    static var previews: some View {
        colortest()
            .environment(\.colorScheme, .dark)
    }
}
