//
//  TransactionListView.swift
//  SwiftUICoreDataSpendingTracker
//
//  Created by mystic on 2022/12/27.
//

import SwiftUI

struct TransactionListView: View {
    let card: Card
    
    init(card: Card) {
        self.card = card
        fetchRequest = FetchRequest<CardTransaction>(
            entity: CardTransaction.entity(),
            sortDescriptors: [.init(key: "timestamp", ascending: false)],
            predicate: .init(format: "card == %@", self.card)
            )
    }
    
    @State private var shouldShowAddTransactionForm = false
    @State private var shouldShowFilterSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var fetchRequest: FetchRequest<CardTransaction>
    
    var body: some View {
        VStack {
            if fetchRequest.wrappedValue.isEmpty {
                Text("Get started by adding your first transaction")
                Button {
                    shouldShowAddTransactionForm.toggle()
                } label: {
                    Text("+ Transaction")
                        .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                        .background(Color.label)
                        .foregroundColor(.systemBackground)
                        .font(.headline)
                        .cornerRadius(10)
                }
            } else {
                HStack {
                    Spacer()
                    addTransactionButton
                    filterButton
                        .sheet(isPresented: $shouldShowFilterSheet) {
                            FilterSheet(selectedCategories: self.selectedCategories) { categories in
                                self.selectedCategories = categories
                            }
                        }
                }.padding(.horizontal)
                ForEach(filterTransactions(selectedCategories: self.selectedCategories)) { transaction in
                    CardTransactionView(transaction: transaction)
                }
            }
        }.fullScreenCover(isPresented: $shouldShowAddTransactionForm) { AddTransactionForm(card: self.card) }
    }
    
    @State var selectedCategories = Set<TransactionCategory>()
    
    private func filterTransactions(selectedCategories: Set<TransactionCategory>) -> [CardTransaction] {
        if selectedCategories.isEmpty { return Array(fetchRequest.wrappedValue) }
        return fetchRequest.wrappedValue.filter { transaction in
            var shouldKeep = false
            if let categories = transaction.categories as? Set<TransactionCategory> {
                categories.forEach { category in
                    if selectedCategories.contains(category) {
                        shouldKeep = true
                    }
                }
            }
            return shouldKeep
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    private var filterButton: some View {
        Button {
            shouldShowFilterSheet.toggle()
        } label: {
            HStack {
                Image(systemName: "line.horizontal.3.decrease.circle")
                Text("Filter")
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color(.systemBackground))
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color(.label))
            .cornerRadius(5)
        }
    }
    
    private var addTransactionButton: some View {
        Button {
            shouldShowAddTransactionForm.toggle()
        } label: {
            Text("+ Transaction")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(.systemBackground))
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Color(.label))
                .cornerRadius(5)
        }
    }
}

struct FilterSheet: View {
    @State var selectedCategories: Set<TransactionCategory>
    
    let didSaveFilter: (Set<TransactionCategory>) -> ()
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TransactionCategory.timestamp, ascending: false)], animation: .default)
    private var categories: FetchedResults<TransactionCategory>
    
    var body: some View {
        NavigationView {
            Form {
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
                }
            }
            .navigationTitle("Select filters")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { saveButton }
            }
        }
    }
    
    @Environment(\.dismiss) var dismiss
    
    private var saveButton: some View {
        Button {
            didSaveFilter(selectedCategories)
            dismiss.callAsFunction()
        } label: {
            Text("Save")
        }
    }
}

struct CardTransactionView: View {
    let transaction: CardTransaction
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    @State var shouldPresentationActionSheet = false
    
    private func delete() {
        withAnimation {
            do {
                let context = PersistenceController.shared.container.viewContext
                context.delete(transaction)
                try context.save()
            } catch {
                print("Failed to delete transaction: \(error)")
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(transaction.name ?? "").font(.headline)
                    if let date = transaction.timestamp {
                        Text(dateFormatter.string(from: date))
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Button {
                        shouldPresentationActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis").font(.system(size: 24))
                    }.padding(EdgeInsets(top: 6, leading: 8, bottom: 4, trailing: 0))
                        .confirmationDialog(transaction.name ?? "", isPresented: $shouldPresentationActionSheet) {
                            Button("Cancel", role: .cancel) { shouldPresentationActionSheet.toggle() }
                            Button("Delete", role: .destructive) { delete() }
                        }
                    Text(String(format: "%.2f", transaction.amount))
                }
            }
            if let categories = transaction.categories as? Set<TransactionCategory> {
                let sortedByTimestampCategories = Array(categories).sorted(by: { $0.timestamp?.compare($1.timestamp ?? Date()) == .orderedDescending })
                HStack {
                    ForEach(sortedByTimestampCategories) { category in
                        HStack {
                            if let data = category.colorData,
                               let uicolor = UIColor.color(data: data) {
                                Text(category.name ?? "")
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 8)
                                    .background(Color(uiColor: uicolor))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    Spacer()
                }
            }
            if let photoData = transaction.photoData, let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            }
            HStack { Spacer() }
        }
        .foregroundColor(.label)
        .padding()
        .background(Color.cardTransactionBackground)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
    
    @Environment(\.colorScheme) var colorScheme
}

struct TransactionListView_Previews: PreviewProvider {
    static let firstCard: Card? = {
        let context = PersistenceController.shared.container.viewContext
        let request = Card.fetchRequest()
        request.sortDescriptors = [.init(key: "timestamp", ascending: false)]
        return try? context.fetch(request).first
    }()
    static var previews: some View {
        NavigationView {
            ScrollView {
                if let card = firstCard {
                    TransactionListView(card: card)
                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
