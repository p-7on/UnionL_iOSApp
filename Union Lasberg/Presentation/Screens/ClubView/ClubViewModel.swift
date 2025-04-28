//
//  ClubViewModel.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import Foundation
import Combine

class ClubViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isLoading = false
    
    @Published var isAlertShowing = false
    @Published var alertItem: AlertItem?
    
    @Published var cancellables = Set<AnyCancellable>()
    private let postsUseCase = PostUseCase(repository: PostRepository())
    
    init() {
        fetchClubPosts()
    }
    
    func fetchClubPosts() {
        isLoading = true
        postsUseCase.getAllPosts(from: .clubPosts)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.showAlert(AlertContext.invalidURL)
                    case .invalidResponse:
                        self.showAlert(AlertContext.invalidResponse)
                    case .invalidData:
                        self.showAlert(AlertContext.invalidData)
                    case .unableToComplete:
                        self.showAlert(AlertContext.unableToComplete)
                    }
                case .finished:
                    print("loaded posts successfully...")
                }
            } receiveValue: { posts in
                self.posts = posts
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func showAlert(_ alert: AlertItem) {
        alertItem = alert
        isAlertShowing = true
    }
    
}
