//
//  NetworkManager.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    func fetch<T :Decodable> (url: URL) -> AnyPublisher<T, APIError> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let urlResponse = response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else if error is DecodingError {
                    return .invalidData
                } else if let urlError = error as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet:
                        return .unableToComplete
                    case .timedOut:
                        return .unableToComplete
                    default:
                        return .invalidURL
                    }
                } else {
                    return .unableToComplete
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    
    }
}
