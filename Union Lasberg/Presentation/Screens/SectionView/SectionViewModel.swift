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
        // fetchSectionPosts(from: .soccerPosts)
        fetchAllSectionPosts()
    }
    
    func fetchAllSectionPosts() {
        isLoading = true

        let soccerPublisher = sectionPostUseCase.getAllPosts(from: .soccerPosts)
            .handleEvents(receiveOutput: { self.soccerPosts = $0 })
            .catch { error -> Just<[Post]> in
                self.handleError(error) // 🔹 Fehlerbehandlung
                return Just([])
            }

        let tennisPublisher = sectionPostUseCase.getAllPosts(from: .tennisPosts)
            .handleEvents(receiveOutput: { self.tennisPosts = $0 })
            .catch { error -> Just<[Post]> in
                self.handleError(error)
                return Just([])
            }

        let fitnessPublisher = sectionPostUseCase.getAllPosts(from: .fitnessPosts)
            .handleEvents(receiveOutput: { self.fitnessPosts = $0 })
            .catch { error -> Just<[Post]> in
                self.handleError(error)
                return Just([])
            }

        let runningPublisher = sectionPostUseCase.getAllPosts(from: .runningPosts)
            .handleEvents(receiveOutput: { self.runningPosts = $0 })
            .catch { error -> Just<[Post]> in
                self.handleError(error)
                return Just([])
            }

        Publishers.Merge4(soccerPublisher, tennisPublisher, fitnessPublisher, runningPublisher)
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

    
    /*
    func fetchSectionPosts(from endpoint: APIEndpoint) {
        isLoading = true
        sectionPostUseCase.getAllPosts(from: endpoint)
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
                    print("loaded section posts successfully...")
                }
            } receiveValue: { posts in
                switch endpoint {
                case .soccerPosts:
                    self.soccerPosts = posts
                case .tennisPosts:
                    self.tennisPosts = posts
                case .runningPosts:
                    self.runningPosts = posts
                case .fitnessPosts:
                    self.fitnessPosts = posts
                default:
                    print("no action")
                }
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
     */
    

    
    func showAlert(_ alert: AlertItem) {
        alertItem = alert
        isAlertShowing = true
    }
    
}
