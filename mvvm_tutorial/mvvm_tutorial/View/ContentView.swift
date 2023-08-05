//
//  ContentView.swift
//  mvvm_tutorial
//
//  Created by mystic on 2022/05/08.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var itemmanager : itemviewmodel = itemviewmodel()
    var body: some View {
        VStack {
            ScrollView{
                Divider().opacity(0)
                ForEach(itemmanager.items){ i in
                    Text(i.name)
                }
            }
            Spacer()
            Button {
                itemmanager.additem(item: item(name: String(Int.random(in: 0...100))))
            } label: {
                Text("add item")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(20)
            }
        }.preferredColorScheme(.dark)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
