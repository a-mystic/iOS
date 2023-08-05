//
//  Cardgestureview.swift
//  gesture
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct Cardgestureview: View {
    @State private var spacing : CGFloat = 20
    @State private var scale : CGFloat = 0.02
    @State private var angle : CGFloat = 5
    @GestureState private var translation : CGSize = .zero
    var frontCard : some View{
        let dragGesture = DragGesture().updating($translation){ value, state, _ in
            state = value.translation
        }
        return Card()
            .offset(translation)
            .shadow(radius: 4, x:2,y:2)
            .onLongPressGesture {
                
            }
            .simultaneousGesture(dragGesture)
    }
    var backgroundCards : some View{
        ForEach(0..<10, id:\.self){ _ in
            Card()
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                backgroundCards
                frontCard
            }
            Spacer()
            controller
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Cardgestureview_Previews: PreviewProvider {
    static var previews: some View {
        Cardgestureview()
    }
}
