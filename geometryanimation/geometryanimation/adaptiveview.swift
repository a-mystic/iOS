//
//  adaptiveview.swift
//  geometryanimation
//
//  Created by mystic on 2022/05/06.
//

import SwiftUI

struct adaptiveview: View {
    let circlelist : [String] = ["one","two","three"]
    @State var isselected : String? = nil
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(circlelist,id: \.self){ circle in
                            Circle()
                                .frame(width:100,height: 100)
                                .overlay(Text(circle).foregroundColor(.white))
                                .matchedGeometryEffect(id: circle, in: namespace, properties: .frame, anchor:.center,isSource: circle != isselected)
                                .onTapGesture {
                                    withAnimation {
                                        isselected = circle
                                    }
                                }
                                .zIndex(circle == isselected ? 1 : 0)
                        }
                    }
                }
                Rectangle()
                    .frame(width:0,height: 300)
            }
            if isselected != nil{
                Circle()
                    .overlay(Text(isselected!).foregroundColor(.white))
                    .shadow(radius: 20)
                    .blur(radius: 20)
                    .padding()
                    //.transition(.scale)
                    .matchedGeometryEffect(id: isselected!, in: namespace, properties: .frame, isSource: isselected != nil)
                    .onTapGesture {
                        withAnimation {
                            
                            isselected = nil
                        }
                    }
                
            }
        }
    }
}

struct adaptiveview_Previews: PreviewProvider {
    static var previews: some View {
        adaptiveview()
    }
}
