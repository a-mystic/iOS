//
//  swapview.swift
//  geometryanimation
//
//  Created by mystic on 2022/05/06.
//

import SwiftUI

struct swapview: View {
    @State var isvertical = true
    @Namespace var namespace
    var body: some View {
        VStack{
            if isvertical{
                VStack{
                    content
                }
            }else{
                HStack{
                    
                    content
                }
            }
            Button {
                withAnimation {
                    isvertical.toggle()
                }
            } label: {
                Text("swap")
            }
        }
    }
    @ViewBuilder var content : some View{
        Group{
            Rectangle()
                .matchedGeometryEffect(id: "rectangle", in: namespace)
            Circle()
                .matchedGeometryEffect(id: "circle", in: namespace)
        }
    }
}

struct swapview_Previews: PreviewProvider {
    static var previews: some View {
        swapview()
    }
}
