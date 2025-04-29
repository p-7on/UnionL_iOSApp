//
//  SectionViewModel.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 18.03.25.
//

import Foundation
import Combine

class SectionViewModel: ObservableObject {
    
    let sections: [FilterCategory] = FilterCategory.allCases
    @Published var selectedCategory: FilterCategory = .Fußball
    
    @Published var soccerPosts: [Post] = []
    @Published var runningPosts: [Post] = []
    @Published var tennisPosts: [Post] = []
    @Published var fitnessPosts: [Post] = []
    @Published var isLoading = false
    
    @Published var alertItem: AlertItem?
    @Published var isAlertShowing = false
    
    @Published var cancellables = Set<AnyCancellable>()
    private let sectionPostUseCase = PostUseCase(repository: PostRepository())
    
    init() {
        fetchAllSectionPosts()
    }
    
    func fetchAllSectionPosts() {
        isLoading = true

        let endpoints: [(APIEndpoint, ReferenceWritableKeyPath<SectionViewModel, [Post]>)] = [
            (.soccerPosts, \.soccerPosts),
            (.tennisPosts, \.tennisPosts),
            (.fitnessPosts, \.fitnessPosts),
            (.runningPosts, \.runningPosts)
        ]

        let publishers = endpoints.map { endpoint, keyPath in
            sectionPostUseCase.getAllPosts(from: endpoint)
                .handleEvents(receiveOutput: { [weak self] posts in
                    self?[keyPath: keyPath] = posts
                })
                .catch { [weak self] error -> Just<[Post]> in
                    self?.handleError(error)
                    return Just([])
                }
        }

        Publishers.MergeMany(publishers)
            .collect()
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }

    func handleError(_ error: APIError) {
        DispatchQueue.main.async {
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
        }
    }
    
    func showAlert(_ alert: AlertItem) {
        alertItem = alert
        isAlertShowing = true
    }
    
}
