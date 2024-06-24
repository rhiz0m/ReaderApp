//
//  UserData.swift
//  ReaderApp
//
//  Created by Andreas Antonsson on 2024-06-24.
//

import Foundation
import FirebaseFirestoreSwift

struct UserData: Codable {
    @DocumentID var id: String?
}
