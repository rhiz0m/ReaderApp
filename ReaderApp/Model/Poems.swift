//
//  Poems.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-07-24.
//

import Foundation

struct Poems: Codable {
    let poemLines: [String]
    
    private enum CodingKeys: String, CodingKey {
        case poemLines = "lines"
    }
}

