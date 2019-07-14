//
//  NetworkError.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidData
    case decodingError
    case error(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "There is an error with URL."
        case .invalidData:
            return "The Data from response is invalid!"
        case .decodingError:
            return "There is an error with decoding data into model object."
        case .error(let error):
            return error.localizedDescription
        }
    }
}
