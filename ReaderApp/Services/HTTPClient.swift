//
//  HTTPClient.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-07-24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

struct HTTPClient {
    func fetchPoems(completion: @escaping (Result<[Poems], NetworkError>) -> Void) {
        guard let url = URL.forPoemsByAuthor() else {
            completion(.failure(.badUrl))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let poemResponse = try? JSONDecoder().decode([Poems].self, from: data) else {
                return completion(.failure(.decodingError))
                
            }
            print("This is the poemresponse \(poemResponse)")

            completion(.success(poemResponse))
            
        }.resume()
    }
}

