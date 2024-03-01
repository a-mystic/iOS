//
//  ContentView.swift
//  Observer pattern
//
//  Created by a mystic on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    private var sensor = TemparatureSensor()
    private var display = Display()
    
    var body: some View {
        Button("Set temparature") {
            sensor.updateTemparature(to: 20)
        }
        .onAppear {
            sensor.addObserver(display)
        }
    }
}

protocol Observer {
    func updateDisplayTemparature(_ temparature: Double)
}

class TemparatureSensor {
    private var observers: [Observer] = []
    private var temparature: Double = 0 {
        didSet {
            notifyToObserver()
        }
    }
    
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func notifyToObserver() {
        observers.forEach { $0.updateDisplayTemparature(temparature) }
    }
    
    func updateTemparature(to temparature: Double) {
        self.temparature = temparature
    }
}

class Display: Observer {
    func updateDisplayTemparature(_ temparature: Double) {
        print("Temparature: \(temparature)")
    }
}

#Preview {
    ContentView()
}
