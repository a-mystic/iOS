//
//  ContentView.swift
//  CoreDataTutorial
//
//  Created by a mystic on 2023/06/23.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            Button("Add") {
                let names = ["one", "two", "three"]
                let student = Student(context: moc)
                student.id = UUID()
                student.name = names.randomElement()!
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
