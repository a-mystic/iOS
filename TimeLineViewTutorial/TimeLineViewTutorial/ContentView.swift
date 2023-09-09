//
//  ContentView.swift
//  TimeLineViewTutorial
//
//  Created by a mystic on 2023/09/09.
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGFloat = 0
    
    private var date: Date {
        Date()
    }
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 0.001)) { timeline in  // computed property
            VStack {
                Text(date.description)
                Text("👻")
                    .font(.largeTitle)
                    .offset(x: offset)
                    .onChange(of: timeline.date) { newValue in
                        offset += 1
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
