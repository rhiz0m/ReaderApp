//
//  URL+Extensions.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-07-24.
//

import Foundation

extension URL {
    static func getPoetryURL() -> URL? {
        URL(string: "\(Constants.poetryURL)")
    }
}
