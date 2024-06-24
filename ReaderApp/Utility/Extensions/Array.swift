//
//  Array.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-18.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
