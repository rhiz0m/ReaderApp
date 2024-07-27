//
//  PoemsDao.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-07-25.
//

import Foundation

struct PoemsDAO {
    private let httpClient = HTTPClient()
    
    func fetchPoems(completion: @escaping (Result<[Poems], NetworkError>) -> Void) {
        guard let url = URL.getPoetryURL() else {
            return completion(.failure(.badUrl))
        }
        
        httpClient.get(url: url) { result in
            switch result {
            case .success(let data):
                guard let poems = try? JSONDecoder().decode([Poems].self, from: data) else {
                    return completion(.failure(.decodingError))
                }
                completion(.success(poems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
