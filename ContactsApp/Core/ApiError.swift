//
//  APIeError.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case networkError
    case fetchError
    case decodeError
    case noData
    
    var errorMessage: String {
        switch self {
        case .networkError: return "Something went wrong!"
        case .fetchError: return "Unable to Fetch!"
        case .decodeError: return "Unable to decode the response"
        case .noData: return "Data not found"
        }
    }
}
