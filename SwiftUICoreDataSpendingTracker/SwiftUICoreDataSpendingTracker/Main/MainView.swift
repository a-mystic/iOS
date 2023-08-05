//
//  MainView.swift
//  SwiftUICoreDataSpendingTracker
//
//  Created by mystic on 2022/12/25.
//

import SwiftUI

struct MainView: View {
    @State private var shouldPresentAddCardForm = false
    @State private var shouldShowAddTransactionForm = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.timestamp, ascending: false)], animation: .default)
    private var cards: FetchedResults<Card>
    
    @State private var selectedCardHash = -1
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !cards.isEmpty {
                        TabView(selection: $selectedCardHash) {
                            ForEach(cards) { card in
                                CreditCardView(card: card)
                                    .padding(.bottom, 50)
                                    .tag(card.hash)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(height: 280)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .onAppear { self.selectedCardHash = cards.first?.hash ?? -1 }
                    if let firstIndex = cards.firstIndex(where: { $0.hash == selectedCardHash }) {
                        let card = self.cards[firstIndex]
                        TransactionListView(card: card)
                    }
                } else {
                    emptyPromptMessage
                }
                Spacer()
                    .fullScreenCover(isPresented: $shouldPresentAddCardForm) {
                        AddCardForm(card: nil) { card in
                            self.selectedCardHash = card.hash
                        }
                    }
            }
            .navigationTitle("Credit Card")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { addCardButton }
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        addItemButton
                        deleteAllButton
                    }
                }
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    private var emptyPromptMessage: some View {
        VStack {
            Text("You currently have no cards in the system.")
                .padding(.horizontal, 48)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            Button {
                shouldPresentAddCardForm.toggle()
            } label: {
                Text("+ Add Your First Card").foregroundColor(Color(.systemBackground))
            }
            .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
            .background(Color(.label))
            .cornerRadius(5)
        }.font(.system(size: 22, weight: .semibold))
    }
    
    private var deleteAllButton: some View {
        Button {
            cards.forEach { viewContext.delete($0) }
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        } label: {
            Text("Delete All")
        }
    }
    
    var addItemButton: some View {
        Button {
            withAnimation {
                let viewContext = PersistenceController.shared.container.viewContext
                let card = Card(context: viewContext)
                card.timestamp = Date()
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Add Item")
        }
    }
    
    struct CreditCardView: View {
        let card: Card
        
        init(card: Card) {
            self.card = card
            fetchRequest = FetchRequest<CardTransaction>(
                entity: CardTransaction.entity(),
                sortDescriptors: [.init(key: "timestamp", ascending: false)],
                predicate: .init(format: "card == %@", self.card)
                )
        }
        
        @Environment(\.managedObjectContext) private var viewContext
        
        var fetchRequest: FetchRequest<CardTransaction>
        
        @State private var shouldShowActionSheet = false
        @State private var shouldShowEditForm = false
        @State var refreshId = UUID()
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(card.name ?? "").font(.system(size: 24, weight: .semibold))
                    Spacer()
                    Button {
                        shouldShowActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis").font(.system(size: 20, weight: .bold))
                    }.confirmationDialog(Text(self.card.name ?? ""), isPresented: $shouldShowActionSheet, titleVisibility: .visible) {
                        Button("Cancle", role: .cancel) { shouldShowActionSheet.toggle() }
                        Button("Edit", role: .none) { shouldShowEditForm.toggle() }
                        Button("Delete Card", role: .destructive) { CardDelete() }
                    }
                }
                HStack {
                    Image("visa").resizable().scaledToFit().frame(height: 44).clipped()
                    Spacer()
                    if let balance = fetchRequest.wrappedValue.reduce(0, { $0 + $1.amount }) {
                        Text("Balance: $\(String(format: "%.2f", balance))").font(.system(size: 18, weight: .semibold))
                    }
                }
                Text(card.number ?? "")
                Text("Credit Limit: $\(card.limit)")
                HStack { Spacer() }
            }
            .foregroundColor(.white)
            .padding()
            .background(
                VStack {
                    if let colorData = card.color,
                       let uiColor = UIColor.color(data: colorData),
                       let actualColor = Color(uiColor) {
                        LinearGradient(colors: [actualColor.opacity(0.6), actualColor], startPoint: .center, endPoint: .bottom)
                    } else {
                        Color.purple
                    }
                }
            )
            .cornerRadius(8)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.top, 8)
            .fullScreenCover(isPresented: $shouldShowEditForm) { AddCardForm(card: card) }
        }
        
        private func CardDelete() {
            let viewContext = PersistenceController.shared.container.viewContext
            viewContext.delete(card)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    var addCardButton: some View {
        Button {
            shouldPresentAddCardForm.toggle()
        } label: {
            Text("+ Card")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .background(.black)
                .cornerRadius(5)
        }
    }
}

extension Color {
    static var systemBackground: Self { Color(.systemBackground) }
    static var label: Self { Color(.label) }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView()
            .environment(\.managedObjectContext, viewContext)
    }
}
