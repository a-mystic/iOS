//
//  ContentView.swift
//  testSpaceiOS
//
//  Created by a mystic on 2023/07/15.
//

import SwiftUI
import SwiftData
import Charts

@Model
class data {
    var content: Data
    
    init(content: Data) {
        self.content = content
    }
}

struct ChartData {
    var index: Int
    var value: Int
}

struct ContentView: View {
    @State private var sliderValue: Double = 0.0
    @State private var xPosition: CGFloat = 100
    @State private var isShow = false
    
    private let datas: [ChartData] = [
        .init(index: 0, value: 0),
        .init(index: 1, value: 1),
        .init(index: 2, value: 2),
        .init(index: 3, value: 3),
        .init(index: 4, value: 4),
        .init(index: 5, value: 5)
    ]

    private let ironmanThumnail = URL(string: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_FMjpg_UX1000_.jpg")
    
    @State private var commands: [String] = ["", "", ""]
    @State private var number = 0
    
    @State private var colors: Set<Color> = [.black]
    
    private var color: LinearGradient {
        LinearGradient(colors: Array(colors), startPoint: .bottom, endPoint: .top)
    }
    
    var body: some View {
        VStack {
            Text("Hello")
                .font(.title3)
            Text("Hello")
                .font(.headline)
            Text("Hello")
                .font(.body)
            ProgressView()
                .tint(.red)
        }
//        VStack {
//            Chart(datas, id: \.index) { data in
//                LineMark(x: .value("Index", data.index), y: .value("Strength", data.value))
//                    .foregroundStyle(color)
//            }
//            .frame(width: 300, height: 300)
//            Button("Append") {
//                let color: [Color] = [.black, .blue, .white, .red, .yellow, .orange]
//                colors.insert(color.randomElement()!)
//            }
//        }
//        Text("Hello")
//            .font(.title)
//            .padding()
//            .foregroundStyle(.black)
//            .background {
//                RoundedRectangle(cornerRadius: 12)
//                    .foregroundStyle(.ultraThinMaterial)
//            }
//        VStack {
//            Text("\(number)")
//            Button("Start", action: {
//                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                    number += 1
//                    if number == 4 {
//                        timer.invalidate()
//                    }
//                }
//                print("Hello")
//            })
//        }
//        Text("Hello")
//            .foregroundStyle(.white)
//            .padding()
//            .background {
//                Color.blue
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
//        AsyncImage(url: ironmanThumnail) { image in
//            image
//                .resizable()
//                .frame(width: 300, height: 300)
//        } placeholder: {
//            ProgressView()
//        }
//        .onAppear {
//            printData()
//        }


//        Button("Fetch") {
//            Task {
//                let one = await fetchone()
//                let two = await fetchtwo(one)
//                let three = await fetchthree(two)
//                print(three)
//            }
//        }
//        VStack {
//            if isShow {
//                Text("👻")
//                    .font(.largeTitle)
//                    .transition(.scale(scale: 3).animation(.linear(duration: 3).repeatForever()))
//            }
//            Text("☃️")
//                .transition(.asymmetric(insertion: .scale(scale: 3).animation(.linear(duration: 3).repeatForever()), removal: .identity))
//        }
//        .onAppear {
//            isShow.toggle()
//        }
//        VStack {
//            TimelineView(.periodic(from: .now, by: 0.1)) { timeline in
//                Text("👻")
//                    .position(x: xPosition)
//                    .animation(.linear(duration: 3), value: xPosition)
//                    .onAppear {
//                        xPosition = 600
//                    }
//                    }
//                }
            }


//        Button("Change") {
//            show = true
//        }
//        .onChange(of: show) { newValue in
//            print("Show")
//        }
//        VStack {
//            if show {
//                Rectangle()
//                    .transition(.asymmetric(insertion: .scale, removal: .slide).animation(.easeInOut))
//            }
//            transitionButton
//        }
//        .frame(width: 300, height: 300)
//        .overlay {
//            cont
//        }
    
    private func getDataFromImage() -> Data? {
        return UIImage(named: "binary")?.pngData()
    }
    
    private func printData() {
        if let data = getDataFromImage() {
            print(data)
        }
    }
    
    @State private var show = false
    
    var transitionButton: some View {
        Button("transition") {
            withAnimation {
                show.toggle()
            }
        }
    }
    
    private func fetchone() async -> String {
        return "1"
    }
    
    private func fetchtwo(_ str: String) async -> String {
        return str + "2"
    }
    
    private func fetchthree(_ str: String) async -> String {
        return str + "3"
    }
}

class dummyController: UIViewController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct mystic: View {
    var body: some View {
        VStack {
            Text("mystic")
                .opacity(isShow ? 1 : 0)
            Button {
                isShow.toggle()
            } label: {
                Text("change")
            }
        }
    }
    
    @State private var isShow = false
}

struct wave: View {
    @State private var waveValue: Double = 0.0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                let yPos = geometry.size.height / 2 * (1 - CGFloat(sin(waveValue * 2 * .pi)))
                Text("Hello, SwiftUI")
                    .position(x: self.waveValue * geometry.size.width, y: yPos)
                    .animation(.easeInOut(duration: 0.3), value: waveValue)
            }
            .frame(height: 200)
            .onAppear { wave() }
            waveButton
        }
    }
    
    var waveButton: some View {
        Button("Wave") {
            wave()
        }
    }
    
    private func wave() {
        waveValue = 0
        Task {
            for _ in 0..<1000 {
                withAnimation(.linear(duration: 0.3)) {
                    waveValue += 0.001
                }
                usleep(1000)
            }
        }
    }
}
