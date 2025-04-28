//
//  APIService.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchPosts(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError>
    func fetchMedia(for id: Int) -> AnyPublisher<MediaItem, APIError>
    // func fetchClubPosts() -> AnyPublisher<[Post], APIError>
}

class APIService: APIServiceProtocol {
    
    // private let homePostsURL = "https://www.union-lasberg.at/wp-json/wp/v2/posts"
    // private let mediaURL = "https://www.union-lasberg.at/wp-json/wp/v2/media/"
    // private let clubPostsURL = "https://www.union-lasberg.at/wp-json/wp/v2/posts?categories=9"
    
    func fetchPosts(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError> {
        guard let url = URL(string: endpoint.url) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return NetworkManager.shared.fetch(url: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMedia(for id: Int) -> AnyPublisher<MediaItem, APIError> {
        guard let url = URL(string: APIEndpoint.media.url + "\(id)") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return NetworkManager.shared.fetch(url: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    /*
    func fetchClubPosts() -> AnyPublisher<[Post], APIError> {
        guard let url = URL(string: clubPostsURL) else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return NetworkManager.shared.fetch(url: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
     */
    
    
}
