import SwiftUI

struct CardFront : View {
    private let width : CGFloat = 250
    private let height : CGFloat = 250
    @Binding var degree : Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
                .foregroundColor(.orange)
                .frame(width: width, height: height)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .fill(.white)
                .frame(width: width, height: height)
            Text("👻")
                .font(.largeTitle)
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack : View {
    private let width : CGFloat = 250
    private let height : CGFloat = 250
    
    @Binding var degree : Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: width, height: height)
                .foregroundColor(.orange)
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))

    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            CardFront(degree: $frontDegree)
            CardBack(degree: $backDegree)
        }.onTapGesture {
            flipCard ()
        }
    }
    
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    @State private var isFlipped = false
    
    private let width : CGFloat = 200
    private let height : CGFloat = 250
    private let durationAndDelay : CGFloat = 0.2
    
    private func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
