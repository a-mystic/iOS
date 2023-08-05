//
//  ImagePicker.swift
//  uikit integration
//
//  Created by mystic on 2022/05/14.
//

import Foundation
import SwiftUI

struct ImagePickerView : UIViewControllerRepresentable{
    @Binding var pickedImage : Image?
    final class Coordinator : NSObject{
        let parent : ImagePickerView
        init(_ imagepickerview : ImagePickerView){
            self.parent = imagepickerview
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = context.coordinator
        imagepickercontroller.allowsEditing = true
        return imagepickercontroller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}

extension ImagePickerView.Coordinator : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalimage = info[.originalImage] as! UIImage
        let editedImage = info[.editedImage] as! UIImage
        let selectedImage = editedImage ?? originalimage
        parent.pickedImage = Image(uiImage: selectedImage)
        picker.dismiss(animated: true)
    }
}
