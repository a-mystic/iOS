//
//  AddTransactionForm.swift
//  SwiftUICoreDataSpendingTracker
//
//  Created by mystic on 2022/12/27.
//

import SwiftUI

struct AddTransactionForm: View {   // L16
    let card: Card
    
    init(card: Card) {
        self.card = card
        let context = PersistenceController.shared.container.viewContext
        let request = TransactionCategory.fetchRequest()
        request.sortDescriptors = [.init(key: "timestamp", ascending: false)]
        do {
            let result = try context.fetch(request)
            if let first = result.first {
                self._selectedCategories = .init(initialValue: [first])
            }
        } catch {
            print("Failed to preselect categories")
        }
    }
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var photoData: Data?
    @State private var shouldPresentPhotoPicker = false
    
    @State private var selectedCategories = Set<TransactionCategory>()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Information") {
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section("Categories") {
                    NavigationLink("Select categories") {
                        CategoriesListView(selectedCategories: $selectedCategories)
                        .navigationTitle("Categories")
                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    }
                    let sortedByTimestampCategories = Array(selectedCategories).sorted(by: { $0.timestamp?.compare($1.timestamp ?? Date()) == .orderedDescending })
                    ForEach(sortedByTimestampCategories) { category in
                        HStack(spacing: 12) {
                            if let data = category.colorData,
                               let uicolor = UIColor.color(data: data) {
                                Spacer().frame(width:30, height: 10).background(Color(uiColor: uicolor))
                            }
                            Text(category.name ?? "")
                        }
                    }
                }
                Section("Photo/Receipt") {
                    Button {
                        shouldPresentPhotoPicker.toggle()
                    } label: {
                        Text("Select Photo")
                    }.fullScreenCover(isPresented: $shouldPresentPhotoPicker) {
                        PhotoPickerView(photoData: $photoData)
                    }
                    if let data = self.photoData, let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { cancelButton }
                ToolbarItem(placement: .navigationBarTrailing) { saveButton }
            }
        }
    }
    
    struct PhotoPickerView: UIViewControllerRepresentable {
        @Binding var photoData: Data?
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            private let parent: PhotoPickerView
            
            init(parent: PhotoPickerView) {
                self.parent = parent
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true)
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                let image = info[.originalImage] as? UIImage
                let resizedImage = image?.resized(to: CGSize(width: 500, height: 500))
                let imageData = resizedImage?.jpegData(compressionQuality: 0.5)
                self.parent.photoData = imageData
                picker.dismiss(animated: true)
            }
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = context.coordinator
            return imagePicker
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
    
    private var saveButton: some View {
        Button {
            let context = PersistenceController.shared.container.viewContext
            let transaction = CardTransaction(context: context)
            transaction.name = self.name
            transaction.timestamp = self.date
            transaction.amount = Float(self.amount) ?? 0
            transaction.photoData = self.photoData
            transaction.card = self.card
            transaction.categories = self.selectedCategories as NSSet
            do {
                try context.save()
                dismiss.callAsFunction()
            } catch {
                print("Failed to save transaction \(error)")
            }
        } label: {
            Text("Save")
        }
    }
    
    private var cancelButton: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Text("Cancel")
        }
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            let hScale = newSize.height / size.height
            let vScale = newSize.width / size.width
            let scale = max(hScale, vScale)
            let resizeSize = CGSize(width: size.width*scale, height: size.height*scale)
            var middle = CGPoint.zero
            if resizeSize.width > newSize.width {
                middle.x -= (resizeSize.width - newSize.width) / 2.0
            }
            if resizeSize.height > newSize.height {
                middle.y -= (resizeSize.height - newSize.height) / 2.0
            }
            self.draw(in: CGRect(origin: middle, size: resizeSize))
        }
    }
}

struct AddTransactionForm_Previews: PreviewProvider {
    static let firstCard: Card? = {
        let context = PersistenceController.shared.container.viewContext
        let request = Card.fetchRequest()
        request.sortDescriptors = [.init(key: "timestamp", ascending: false)]
        return try? context.fetch(request).first
    }()
    static var previews: some View {
        if let card = firstCard {
            AddTransactionForm(card: card)
        }
    }
}
