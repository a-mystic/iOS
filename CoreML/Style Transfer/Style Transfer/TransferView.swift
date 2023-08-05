//
//  TransferView.swift
//  Style Transfer
//
//  Created by mystic on 2022/07/17.
//

import SwiftUI
import UIKit

struct TransferView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {    }
    
    typealias UIViewControllerType = CameraViewController
    
    
}
