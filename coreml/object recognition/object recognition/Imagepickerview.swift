//
//  Imagepickerview.swift
//  object recognition
//
//  Created by mystic on 2022/05/17.
//

import SwiftUI

struct imagepicker : UIViewControllerRepresentable{
    @Binding var uiImage : UIImage?
    @Binding var ispresenting : Bool
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = context.coordinator
        return imagepicker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    class Coordinator : NSObject, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        let parent: imagepicker
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.uiImage = info[.originalImage] as? UIImage
            parent.ispresenting = false
            }

            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.ispresenting = false
            }
        init(_ imagePicker : imagepicker){
            self.parent = imagePicker
        }
    }
    
}
