//
//  ContentView.swift
//  tabv
//
//  Created by mystic on 2022/04/03.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
                buttonpage()
                    .tabItem {
                        Image(systemName: "house")
                        Text("home")
            }
            
            scro()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("flame")
                }
        }.preferredColorScheme(.dark)
         .edgesIgnoringSafeArea(.all)
            
    }
}

struct scro : View{
    var lineargradientcolor = LinearGradient(gradient: Gradient(colors: [Color.purple,Color.pink,Color.white]), startPoint: .top, endPoint: .bottom)
    
    var body: some View{
        ScrollView{
            Rectangle()
                .frame(width: .infinity, height: 0)
            VStack{
                ForEach(0..<100){ item in
                    HStack(alignment:.center){
                        Circle()
                            .opacity(0)
                            .background(lineargradientcolor)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("content\(item)")
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
            .padding()
            .frame(width:500)
    }
}

struct buttonpage : View{
    var currentdate = ""
    func getcurrentdate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" //HH:mm:ss"
        let current_date_string = formatter.string(from: Date())
        return current_date_string
    }
    init(){
        currentdate = getcurrentdate()
    }
    @State var datearray = ["abc":"123"]

    var minusbuttoncolor = LinearGradient(gradient: Gradient(colors: [Color.red,Color.pink,Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
    var plusbuttoncolor = LinearGradient(gradient: Gradient(colors: [Color.purple,Color.pink,Color.white]), startPoint: .top, endPoint: .bottom)
    
    @State var totalnumber : Int = 0
    var body: some View{
        VStack{
            Text("Total:\(datearray.count == 1 ? "not" : datearray[currentdate]!)")
                .font(.largeTitle)
            HStack{
                Button(action: {
                    totalnumber = totalnumber - 1
                    datearray[currentdate] = String(totalnumber)
                }, label: {
                    VStack{
                        Circle()
                            .opacity(0)
                            .background(minusbuttoncolor)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("Minus button")
                            .foregroundColor(.white)
                    }
                    
                })
                Spacer()
                Button(action: {
                    totalnumber = totalnumber + 1
                    datearray[currentdate] = String(totalnumber)
                }, label: {
                    VStack{
                        Circle()
                            .opacity(0)
                            .background(plusbuttoncolor)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text("Plus button")
                            .foregroundColor(.white)
                    }
                })
                
            }
        }.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

