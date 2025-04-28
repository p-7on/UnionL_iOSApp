//
//  HomePostUseCase.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation
import Combine

protocol PostUseCaseProtocol {
    func getAllPosts(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError>
    func getPostsHTML(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError>
    func getMedia(for ids: [Int]) -> AnyPublisher<[MediaItem], APIError>
    // func getAllClubPosts() -> AnyPublisher<[Post], APIError>
    // func getClubPostsHTML() -> AnyPublisher<[Post], APIError>
}

class PostUseCase: PostUseCaseProtocol {
    
    private let repository: PostRepositoryProtocol
    
    init(repository: PostRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllPosts(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError> {
        return getPostsHTML(from: endpoint)
            .flatMap { posts in
                self.getMedia(for: posts.map { $0.featuredMediaID })
                    .map { mediaItems in
                        posts.map { post in
                            var updatedPost = post
                            if let mediaItem = mediaItems.first(where: { $0.id == post.featuredMediaID }) {
                                updatedPost.imageURL = mediaItem.imageURL
                            }
                            return updatedPost
                        }
                    }
            }
            .eraseToAnyPublisher()
    }
    
    internal func getPostsHTML(from endpoint: APIEndpoint) -> AnyPublisher<[Post], APIError> {
        return repository.fetchPosts(from: endpoint)
            .map( { (response: [Post]) in
                response.map { post in
                    var updatedPost = post
                    updatedPost.title = updatedPost.title.htmlToString()
                    updatedPost.content = updatedPost.content.htmlToString()
                    updatedPost.excerpt = updatedPost.excerpt.htmlToString()
                    return updatedPost
                }
            })
            .eraseToAnyPublisher()
    }
    
    internal func getMedia(for ids: [Int]) -> AnyPublisher<[MediaItem], APIError> {
        let validIDs = ids.filter { $0 != 0 }
        
        let publishers = validIDs.map { id in
            repository.fetchMedia(for: id)
        }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    
    /*
    func getAllClubPosts() -> AnyPublisher<[Post], APIError> {
        return getClubPostsHTML()
            .flatMap { posts in
                self.getMedia(for: posts.map { $0.featuredMediaID })
                    .map { mediaItems in
                        posts.map { post in
                            var updatedPost = post
                            if let mediaItem = mediaItems.first(where: { $0.id == post.featuredMediaID }) {
                                updatedPost.imageURL = mediaItem.imageURL
                            }
                            return updatedPost
                        }
                    }
            }
            .eraseToAnyPublisher()
    }
    
    func getClubPostsHTML() -> AnyPublisher<[Post], APIError> {
        return repository.fetchClubPosts()
            .map( { (response: [Post]) in
                response.map { post in
                    var updatedPost = post
                    updatedPost.title = updatedPost.title.htmlToString()
                    updatedPost.content = updatedPost.content.htmlToString()
                    updatedPost.excerpt = updatedPost.excerpt.htmlToString()
                    return updatedPost
                }
            })
            .eraseToAnyPublisher()
    }
     */
    
}
