//
//  apiviewmodel.swift
//  api request
//
//  Created by mystic on 2022/05/05.
//

import Foundation


class RequestAPI: ObservableObject {
    static let shared = RequestAPI()
    private init() { }
    @Published var greet : String = ""
    @Published var number : Int = 0
    
    func fetchData(){
        
        guard let url = URL(string: "url") else{
            return
        }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                self.greet = ""
                self.number = 0
                return
            }
            guard let data = data else{
                return
            }
            do{
                let apiResponse = try JSONDecoder().decode(apis.self, from: data)
                DispatchQueue.main.async {
                    self.greet = apiResponse.greeting
                    self.number = apiResponse.number
                }
            }catch(let err){
                print(err.localizedDescription)
            }
        }
        task.resume()
    }
}
