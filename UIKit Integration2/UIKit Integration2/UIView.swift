//
//  UIView.swift
//  UIKit Integration2
//
//  Created by mystic on 2022/06/18.
//
import SwiftUI

class input: UIViewController {
    var text: String
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        let mylabel = UILabel()
        mylabel.text = text
        mylabel.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 80)
        mylabel.font = .boldSystemFont(ofSize: 20)
        mylabel.textColor = .black
        mylabel.textAlignment = .center
        self.view.addSubview(mylabel)
    }
}

struct UIView: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> input {
        let view = input(text: text)
        return view
    }
    
    func updateUIViewController(_ uiViewController: input, context: Context) {    }
    
    typealias UIViewControllerType = input
    var text: String
    
}
