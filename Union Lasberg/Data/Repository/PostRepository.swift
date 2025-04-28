//
//  HomePostRepository.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation
import Combine

protocol PostRepositoryProtocol {
    func fetchPosts(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError>
    func fetchMedia(for id: Int) -> AnyPublisher<MediaItem, APIError>
    // func fetchClubPosts() -> AnyPublisher<[Post], APIError>
}

class PostRepository: PostRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchPosts(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError> {
        return apiService.fetchPosts(from: endpoint)
    }
    
    func fetchMedia(for id: Int) -> AnyPublisher<MediaItem, APIError> {
        return apiService.fetchMedia(for: id)
    }
    
    /*
    func fetchClubPosts() -> AnyPublisher<[Post], APIError> {
        return apiService.fetchClubPosts()
    }
     */

}
