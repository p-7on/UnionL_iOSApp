//
//  APIError.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
