//
//  ContentView.swift
//  testSpaceiOS
//
//  Created by a mystic on 2023/07/15.
//

import SwiftUI

struct ContentView: View {
    let cont = testWrapper()
    
    var body: some View {
        VStack {
            if show {
                Rectangle()
                    .transition(.asymmetric(insertion: .scale, removal: .slide).animation(.easeInOut))
            }
            transitionButton
        }
        .frame(width: 300, height: 300)
        .overlay {
            cont
        }
    }
    
    @State private var show = false
    
    var transitionButton: some View {
        Button("transition") {
            withAnimation {
                show.toggle()
            }
        }
    }
}

class dummyController: UIViewController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct mystic: View {
    var body: some View {
        VStack {
            Text("mystic")
                .opacity(isShow ? 1 : 0)
            Button {
                isShow.toggle()
            } label: {
                Text("change")
            }
        }
    }
    
    func a() {
        let data = [1, 2, 3]
        let set = Set(data)
    }
    
    @State private var isShow = false
}

