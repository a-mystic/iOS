//
//  imagepickerview.swift
//  Style Transfer
//
//  Created by mystic on 2022/07/17.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var Bindingimage: UIImage?
    @Environment(\.presentationMode) var mode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
                init(_ parent: ImagePickerView) {
                    self.parent = parent
                }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.mode.wrappedValue.dismiss()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.Bindingimage = image
            self.parent.mode.wrappedValue.dismiss()
        }
    }
    typealias UIViewControllerType = UIImagePickerController
}
