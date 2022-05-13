import SwiftUI

struct ContentView: View {
    @State var width : CGFloat = 0
    var body: some View {
        VStack {
            Text("leverage:\(Float(width/10))")
            ZStack(alignment:.leading){
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height:6)
            
                Rectangle()
                    .fill(Color.black)
                    .frame(width:self.width,height: 6)
                HStack{
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x:self.width)
                        .gesture(
                        
                            DragGesture()
                                .onChanged({ value in
                                    self.width = value.location.x
                                })
                        
                        )
                }
            }
        }
    }
}
