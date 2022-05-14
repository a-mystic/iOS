//
//  transitionview.swift
//  animation
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct transitionview: View {
    @State private var showtext = false
    var body: some View {
        VStack{
            if showtext{
                Text("transition")
                    .transition(mytransition)
            }
            Button {
                withAnimation {
                    self.showtext.toggle()
                }
            } label: {
                Text("display on/off")
            }

        }
    }
}
extension transitionview{
    var mytransition : AnyTransition {
        let insertion = AnyTransition.offset(x: 300, y: -300).combined(with: .scale)
        let removal = AnyTransition.move(edge: .leading)
        return AnyTransition.asymmetric(insertion: insertion, removal: removal)
    }
}

struct transitionview_Previews: PreviewProvider {
    static var previews: some View {
        transitionview()
    }
}
