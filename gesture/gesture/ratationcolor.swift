//
//  ratationcolor.swift
//  gesture
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct ratationcolor: View {
    @State var rotation : Double = 0
    @State var fillcolor : Color = .blue
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(fillcolor)
            .hueRotation(Angle(degrees: rotation))
            .frame(width:180,height: 180)
            .rotationEffect(Angle(degrees: rotation))
            .contextMenu {
                contex
            }
    }
    var contex : some View{
        VStack{
            if rotation < 180{
                Button {
                    self.rotation += 90
                } label: {
                    Text("90")
                }
            }
            if rotation > -180{
                Button {
                    self.rotation -= 90
                } label: {
                    Text("-90")
                }

            }
            Button {
                let color = [Color.red,Color.green, Color.blue].randomElement()!
                self.fillcolor = color
            } label: {
                Text("change")
            }

        }
    }
}

struct ratationcolor_Previews: PreviewProvider {
    static var previews: some View {
        ratationcolor()
    }
}
