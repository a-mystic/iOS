//
//  SwiftUIViewCapture.swift
//  ARPractice
//
//  Created by a mystic on 2023/01/19.
//

import SwiftUI

struct SwiftUIViewCapture: View {
    @State var capturedImage: UIImage?
    
    var body: some View {
        Button {
            capturedImage = ImageRenderer(content: CaptureView()).uiImage
        } label: {
            Text("Capture")
        }
    }
}

struct CaptureView: View {
    var body: some View {
        Text("CaptureView")
    }
}

struct SwiftUIViewCapture_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewCapture()
    }
}
