//
//  ContentView.swift
//  InputView
//
//  Created by a mystic on 2023/09/22.
//

import SwiftUI

struct ContentView: View {
    private let mbtis = [
        "ISTJ", "ISFJ", "INFJ", "INTJ",
        "ISTP", "ISFP", "INFP", "INTP",
        "ESTP", "ESFP", "ENFP", "ENTP",
        "ESTJ", "ESFJ", "ENFJ", "ENTJ"
    ]
    @AppStorage("MBTI") private var mbti: String = "None"
    @State private var needData = false
    
    
    var body: some View {
        Text(mbti)
            .onAppear {
                if mbti == "None" {
                    needData = true
                } else {
                    needData = false
                }
            }
            .fullScreenCover(isPresented: $needData) {
                Form {
                    HStack {
                        Text("MBTI를 선택해주세요.")
                        mbtiPicker
                    }
                    HStack {
                        Spacer()
                        submit
                        Spacer()
                    }
                }
            }
    }
    
    private var mbtiPicker: some View {
        Picker("MBTI", selection: $mbti) {
            ForEach(mbtis, id: \.self) { mbt in
                Text(mbt)
            }
        }
        .pickerStyle(.wheel)
        .cornerRadius(15)
        .padding()
    }
    
    private var submit: some View {
        Button("submit") {
            needData = false
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ContentView()
}
