//
//  extension.swift
//  SwiftUI need
//
//  Created by mystic on 2022/06/18.
//

import SwiftUI

extension AnyTransition {
    static var fadeAndMove: AnyTransition{
        Self.opacity.combined(with: .move(edge: .top))
    }
}

extension Int{
   var plusTwo_and_returnString: String {
       var empty = self
       empty = empty + 2
       return String(empty)
    }
}


