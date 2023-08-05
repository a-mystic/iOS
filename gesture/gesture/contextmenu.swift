//
//  ContentView.swift
//  gesture
//
//  Created by mystic on 2022/05/14.
//

import SwiftUI

struct contextmenu: View {
    var body: some View {
        List(0..<10){ item in
            Text("\(item)")
                .contextMenu {
                    Button {
                        
                    } label: {
                        Text("완료")
                    }
                    Button {
                        
                    } label: {
                        Text("삭제")
                    }

                }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        contextmenu()
    }
}
