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
        
        // TODO: Add functions to Layer
    }
    
}
