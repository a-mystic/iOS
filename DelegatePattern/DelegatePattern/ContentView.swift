//
//  ContentView.swift
//  DelegatePattern
//
//  Created by a mystic on 2/13/24.
//

import SwiftUI

struct ContentView: View {
    private var networkManager = NetworkManager()
    private var dataHandler = DataHandler()
    
    init() {
        self.networkManager.delegate = dataHandler
    }
    
    var body: some View {
        Button("Fetch data") {
            networkManager.fetchData()
        }
    }
}

protocol NetworkDelegate {
    func didReceiveData(data: String)
    func didReceiveError()
}

class DataHandler: NetworkDelegate {
    func didReceiveData(data: String) {
        print("success get data")
    }
    
    func didReceiveError() {
        print("error occured")
    }
}

class NetworkManager {
    var delegate: NetworkDelegate?
    
    func fetchData() {
        self.delegate?.didReceiveData(data: "Data")
    }
}

#Preview {
    ContentView()
}
