//
//  circlepicker.swift
//  geometryanimation
//
//  Created by mystic on 2022/05/06.
//

import SwiftUI

struct circlepicker: View {
    let items : [String] = ["one", "two", "three"]
    @State private var selected : String = "one"
    @Namespace private var namespace
    
    var body: some View {
        VStack{
            ForEach(items,id:\.self){   item in
                HStack{
                    Circle().stroke(item == selected ? Color.accentColor : .gray).frame(width:15,height: 15)
                        .matchedGeometryEffect(id: item, in: namespace, properties: .frame, isSource: true)
                    Text(item)
                }
                .onTapGesture {
                    withAnimation {
                        selected = item
                    }
                }
            }.background(
                Circle().fill(Color.accentColor).matchedGeometryEffect(id: selected, in: namespace, properties: .frame, isSource: false).frame(width:15,height: 15)
            )
        }
    }
}

struct circlepicker_Previews: PreviewProvider {
    static var previews: some View {
        circlepicker()
    }
}
