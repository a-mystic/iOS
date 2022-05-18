//
//  ContentView.swift
//  coremltest
//
//  Created by mystic on 2022/05/18.
//

import SwiftUI
import CoreML
struct ContentView: View {
    @State var string : String? = nil
    let mlModel : lineartest = {
        do {
            let config = MLModelConfiguration()
            return try lineartest(configuration: config)
        } catch{
            print(error)
            fatalError("couldn't")
        }
    }()
    init(){
        let result = try! mlModel.prediction(x: [1,2,3])
        print(result.var_5[0])
    }
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
