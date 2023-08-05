//
//  makeviews.swift
//  dictionary
//
//  Created by mystic on 2022/06/01.
//

import SwiftUI
import SpriteKit

struct makecontens : View{
    var contents : [String]
    @State var showsheet : Bool = false
    @ObservedObject var detailmanager : manager = manager()
    var testdata = ["백엔드":"백엔드디테일","프론트엔드":"프론트엔드디테일"]
    
    var body: some View{
        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())],spacing: 20) {
            ForEach(contents,id:\.self){ content in
                Button {
                    detailmanager.detailstring = content
                    showsheet.toggle()
                } label: {
                    Rectangle()
                        .stroke()
                        .frame(height:50)
                        .overlay(Text("\(content)"))
                        .foregroundColor(.white)
                        .sheet(isPresented: $showsheet) {
                            if (testdata.keys.contains(detailmanager.detailstring)) {
                                Image(systemName: "hare").font(.largeTitle).foregroundColor(.white)
                                Text("\(testdata[detailmanager.detailstring]!)")
                                    .foregroundColor(.white)
                            } else{
                                Text("not yet")
                                    .foregroundColor(.white)
                            }
                        }
                }
            }
        }
    }
}

class manager : ObservableObject{
    @Published var detailstring : String = ""
}

struct makelazyvgrid : View{
    var scene : SKScene{
        let scene = RainFall()
        scene.size = CGSize(width:300,height:400)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View{
        NavigationView{
            ZStack{
                Spacer()
                    .frame(width:.infinity,height: .infinity)
                SpriteView(scene: scene)
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())],spacing: 20) {
                    ForEach(datas){ item in
                        NavigationLink {
                            makecontens(contents: item.contents)
                        } label: {
                            Rectangle()
                                .stroke()
                                .frame(height:50)
                                .overlay(Text("\(item.title)"))
                                .foregroundColor(.white)
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
        .preferredColorScheme(.dark)
        .edgesIgnoringSafeArea(.all)
    }
}

class RainFall : SKScene{
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .resizeFill
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "rainfall.sks")!
        addChild(node)
    }
}
