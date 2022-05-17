//
//  Imageclassifier.swift
//  object recognition
//
//  Created by mystic on 2022/05/17.
//

import SwiftUI

class ImageClassifier : ObservableObject{
    @Published private var classifier = Classfier()
    
    var imageclass : String? {
        classifier.results
    }
    func detect(uiImage: UIImage){
        guard let ciImage = CIImage(image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }
}
