//
//  PoemsRepository.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-07-25.
//

import Foundation

struct PoemsRepository {
    private let poemsDao = PoemsDAO()
    
    func getPoems(completion: @escaping (Result<[Poems], NetworkError>) -> Void) {
         poemsDao.fetchPoems() { result in
             completion(result)
         }
     }
    
    func mergePoemLines(from poems: [Poems]) -> [String] {
        return poems.map { $0.poemLines.joined(separator: "\n") }
    }
}
