//
//  ContentView.swift
//  APICallPost
//
//  Created by a mystic on 2023/08/29.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        Button("CallPost") {
            call()
        }
    }
    
    private func call() {
        let url = "http://127.0.0.1:8000/items"
        let parameters: [String: Any] = [
            "item": [
                "name": "pencil",
                "description": "that is pencil",
                "price": 100,
                "tax": 10,
                "sub": [
                    "name": "juice Up",
                    "price": 50
                ] as [String : Any]
            ] as [String : Any],
            "limit": [
                "Open": "09:00",
                "Close": "18:00"
            ]
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseDecodable(of: ResponseData.self) { response in
                switch response.result {
                case .success(let data):
                    print(data.receivedItem.name)
                case .failure(let error):
                    print("Error \(error)")
                }
            }
    }
    
    struct ReceivedSubItem: Codable {
        let name: String
        let price: Float
    }

    struct ReceivedItem: Codable {
        let name: String
        let description: String
        let price: Float
        let tax: Float
        let sub: ReceivedSubItem
    }

    struct ReceivedLimit: Codable {
        let Open: String
        let Close: String
    }

    struct ResponseData: Codable {
        let receivedItem: ReceivedItem
        let receivedLimit: ReceivedLimit
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
