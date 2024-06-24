//
//  GridItemState.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-07.
//

import Foundation

class GridItemState {
    var index: Int
    var isSelected: Bool
    
    init(index: Int, isSelected: Bool) {
        self.index = index
        self.isSelected = isSelected
    }
}
