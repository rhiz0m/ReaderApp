//
//  CurrentIndex.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-03-13.
//

import Foundation

protocol CurrentIndex {
    associatedtype IndexType
    var currentIndex: IndexType { get set }
}
