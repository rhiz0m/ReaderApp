//
//  ReaderVelocity.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-22.
//

import Foundation

class ReaderVelocity: ObservableObject {
    @Published var timeInterval: Double
    
    init(_ sliderValue: Double) {
        timeInterval = sliderValue
        
    }
    
    var minSpeed: Double {
        0.0
    }
    
    var maxSpeed: Double {
        2.0
    }
}
