//
//  CategoriesListView.swift
//  SwiftUICoreDataSpendingTracker
//
//  Created by mystic on 2022/12/27.
//

import SwiftUI

struct CategoriesListView: View {
    @State private var name = ""
    @State private var color = Color.blue
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TransactionCategory.timestamp, ascending: false)], animation: .default)
    private var categories: FetchedResults<TransactionCategory>
    
    @Binding var selectedCategories: Set<TransactionCategory>
    
    var body: some View {
        Form {
            Section("Select a category") {
                ForEach(categories) { category in
                    Button {
                        if selectedCategories.contains(category) {
                            selectedCategories.remove(category)
                        } else {
                            selectedCategories.insert(category)
                        }
                    } label: {
                        HStack(spacing: 12) {
                            if let data = category.colorData,
                               let uicolor = UIColor.color(data: data) {
                                Spacer().frame(width:30, height: 10).background(Color(uiColor: uicolor))
                            }
                            Text(category.name ?? "").foregroundColor(.label)
                            Spacer()
                            if selectedCategories.contains(category) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }.onDelete { indexSet in
                    indexSet.forEach {
                        selectedCategories.remove(categories[$0])
                        viewContext.delete(categories[$0])
                    }
                    try? viewContext.save()
                }
            }
            Section("Create a category") {
                TextField("name", text: $name)
                ColorPicker("Color", selection: $color)
                Button(action: handleCreate) {
                    HStack {
                        Spacer()
                        Text("Create").foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(.blue)
                    .cornerRadius(5)
                }.buttonStyle(.plain)
            }
        }
    }
    
    private func handleCreate() {
        let context = PersistenceController.shared.container.viewContext
        let category = TransactionCategory(context: context)
        category.name = self.name
        category.colorData = UIColor(color).encode()
        category.timestamp = Date()
        try? context.save() // hide error
        self.name = ""
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView(selectedCategories: .constant(Set<TransactionCategory>()))
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
