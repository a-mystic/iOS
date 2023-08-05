//
//  AddFoodView.swift
//  CoreDataTutorial2
//
//  Created by a mystic on 2023/07/12.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food name", text: $name)
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                    submit
                }.padding()
            }
        }
    }
    
    var submit: some View {
        HStack {
            Spacer()
            Button("Submit") {
                DataController().addFood(name: name, calories: calories, context: context)
                dismiss.callAsFunction()
            }
            Spacer()
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
