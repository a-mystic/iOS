//
//  EditFoodView.swift
//  CoreDataTutorial2
//
//  Created by a mystic on 2023/07/12.
//

import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name!)", text: $name)
                    .onAppear {
                        name = food.name!
                        calories = food.calories
                    }
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 10)
                }.padding()
                HStack {
                    Spacer()
                    submit
                    Spacer()
                }
            }
        }
    }
    
    var submit: some View {
        Button("Submit") {
            DataController().editFood(food: food, name: name, calories: calories, context: context)
            dismiss.callAsFunction()
        }
    }
}
