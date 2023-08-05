//
//  matchframeexample.swift
//  geometryanimation
//
//  Created by mystic on 2022/05/06.
//

import SwiftUI

struct matchframeexample: View {
    
    @Namespace var namespace
    let geometryid = "geometryid"
    @State var ismatched = false
    
    var body: some View {
        VStack{
            VStack{
                Text("one")
                    .fixedSize()
                    .padding()
                    .border(Color.yellow)
                    .matchedGeometryEffect(id: geometryid, in: namespace, properties: .size, anchor: .center, isSource: ismatched)
                    .zIndex(1)
                    .onTapGesture {
                        withAnimation {
                            ismatched = true
                        }
                    }
                
                Text("two")
                    .matchedGeometryEffect(id: geometryid, in: namespace, properties: .size, anchor: .center, isSource: !ismatched)
                    .onTapGesture {
                        withAnimation {
                            ismatched = false
                        }
                    }
                
                //                Button {
//                    withAnimation {
//                        ismatched.toggle()
//                    }
//                } label: {
//                    Text("match")
//                }

            }.padding()
            .background(
                Rectangle()
                .fill(.red)
                .matchedGeometryEffect(id: geometryid, in: namespace, properties: .frame, anchor: .center, isSource: ismatched)
                .zIndex(0)
                .border(.black,width: 2))
        }
    }
}

struct matchframeexample_Previews: PreviewProvider {
    static var previews: some View {
        matchframeexample()
    }
}
