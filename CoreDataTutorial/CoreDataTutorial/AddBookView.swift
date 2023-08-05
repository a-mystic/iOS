//
//  AddBookView.swift
//  CoreDataTutorial
//
//  Created by a mystic on 2023/06/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var garl = ""
    @State private var review = ""
    
    let garle = ["one", "2", "3"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("name of book", text: $title)
                    TextField("author", text: $author)
                    
                    Picker("garl", selection: $garl) {
                        ForEach(garle, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        try? moc.save()
                    }
                }
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
