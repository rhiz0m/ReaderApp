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

    func get(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void ) {
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            completion(.success(data))
        }.resume()
    }
}


