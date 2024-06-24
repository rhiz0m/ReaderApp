//
//  SelectedTextState.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-10.
//

import Foundation
import SwiftUI

class TextState {
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    var index: Int
    var selectedText: String
    let totalTextLength: Int
    
    var textPercentage: Double {
            let currentWordIndex = homeViewAdapter.currentIndex.0
            let percentage = Double(currentWordIndex) / Double(homeViewAdapter.words.count) * 100
            let clampedPercentage = max(0.0, min(100.0, percentage))
            index = currentWordIndex
            return clampedPercentage.rounded()
    }
    
    init(homeViewAdapter: HomeViewAdapter, index: Int, selectedText: String, totalTextLength: Int) {
        self.homeViewAdapter = homeViewAdapter
        self.index = index
        self.selectedText = selectedText
        self.totalTextLength = totalTextLength
    }
}

