//
//  emojipicker.swift
//  geometryanimation
//
//  Created by mystic on 2022/05/06.
//

import SwiftUI

struct emoji : Identifiable, Hashable{
    var id: UUID = UUID()
    let content : String
    static func createemojis() -> [emoji]{
        let emojis = ["🐤","🙊","🐼","🐶","🐱","🌈"]
        return emojis.map { emo in
            emoji(content: emo)
        }
    }
    
    
}

struct emojipicker: View {
    let emojis = emoji.createemojis()
    @State private var selection = [emoji]()
    @Namespace private var namespace
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("select emoji").font(.title)
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack{
                    Text("your emojis:")
                    ForEach(selection){ item in
                        Text(item.content)
                            .matchedGeometryEffect(id: item.id, in: namespace, isSource:selection.contains(item))
                            .onTapGesture {
                                tappedEmoji(item)
                            }
                    }
                }
            }.background(Color.white.cornerRadius(20).shadow(radius: 10))
                .padding(.horizontal)
            Spacer()
            Divider()
            
            HStack{
                ForEach(emojis){ item in
                    Text(item.content)
                        .matchedGeometryEffect(id: item.id, in: namespace, isSource:!selection.contains(item))
                    
                        .onTapGesture {
                            withAnimation(.spring()){
                                tappedEmoji(item)
                            }
                        }
                }
            }
            .padding()
        }
    }
    func tappedEmoji(_ emoji:emoji){
        if !selection.contains(emoji){
            selection.append(emoji)
        }else if let index = selection.firstIndex(of: emoji){
            selection.remove(at: index)
        }
    }
}

struct emojipicker_Previews: PreviewProvider {
    static var previews: some View {
        emojipicker()
    }
}
