//
//  URL+Extensions.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-07-24.
//

import Foundation

extension URL {
    static func forPoemsByAuthor() -> URL? {
        URL(string: "https://poetrydb.org/author,linecount/shelley;14/lines")
    }
}
