//
//  Home.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var store : Store
  var body: some View {
      NavigationView{
          List(store.products) { product in
              NavigationLink(destination: ProductDetailView(product: product), label:{
                  ProductRow(product: product)
              })
          }.navigationBarTitle("fruit")
      }
     
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
      Home().environmentObject(Store())
  }
}

