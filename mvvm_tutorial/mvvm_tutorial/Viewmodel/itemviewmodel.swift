//
//  itemviewmodel.swift
//  mvvm_tutorial
//
//  Created by mystic on 2022/05/08.
//

import Foundation

class itemviewmodel : ObservableObject{
    @Published var items:[item] = [item(name: "1"),item(name: "2"),item(name: "3")]
    init(){
        
    }
    func additem(item : item){
        self.items.append(item)
    }
}
