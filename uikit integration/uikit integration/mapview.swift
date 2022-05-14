//
//  mapview.swift
//  uikit integration
//
//  Created by mystic on 2022/05/14.
//

import MapKit
import SwiftUI

struct mapview : UIViewRepresentable{
    let coordinate : CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 2500, pitch: 45, heading: 0)
        uiView.setCamera(camera, animated: true)
    }
}

struct mapviewcall : View{
    @State private var coordinate = CLLocationCoordinate2DMake(37.551416, 126.988194)
    let locations : [String: CLLocationCoordinate2D] = [
        "남산":CLLocationCoordinate2DMake(37.551416, 126.988194),
        "시청":CLLocationCoordinate2DMake(37.566308,126.977948),
        "국회":CLLocationCoordinate2DMake(37.531830,126.914187)]
    var body: some View{
        ZStack(alignment: .bottom) {
            mapview(coordinate: self.coordinate)
            HStack(spacing:30){
                ForEach(["남산","시청","국회"], id:\.self){ location in
                    Button {
                        self.coordinate = self.locations[location]!
                    } label: {
                        Text(location)
                    }

                    
                }
            }
        }.edgesIgnoringSafeArea(.top)
    }
}
