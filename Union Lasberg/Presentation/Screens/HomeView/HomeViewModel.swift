//
//  HomeViewModel.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var mediaItems: [MediaItem] = []
    @Published var showInfoView = false
    @Published var isLoading = false
    
    @Published var isAlertShowing = false
    @Published var alertItem: AlertItem?
    
    
    
    @Published var cancellables = Set<AnyCancellable>()
    private let homePostUseCase = PostUseCase(repository: PostRepository())
    
    init() {
        fetchHomePosts()
    }
    
    func fetchHomePosts() {
        isLoading = true
        homePostUseCase.getAllPosts(from: .homePosts)
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
    
    /*
    init() {
        loadData()
    }
    
    /// Lädt Posts und Media-Daten in einer einzigen Combine-Pipeline
    func loadData() {
        isLoading = true
        
        fetchPosts()
            .flatMap { posts in
                self.fetchMedia(for: posts.map { $0.featuredMediaID })
                    .map { mediaItems -> [HomePost] in
                        return posts.map { post in
                            var updatedPost = post
                            if let mediaItem = mediaItems.first(where: { $0.id == post.featuredMediaID }) {
                                updatedPost.imageURL = mediaItem.imageURL
                            }
                            return updatedPost
                        }
                    }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Fehler beim Laden der Daten: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    /// Holt alle Posts von der API
    private func fetchPosts() -> AnyPublisher<[HomePost], Error> {
        let url = URL(string: "https://www.union-lasberg.at/wp-json/wp/v2/posts")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [HomePost].self, decoder: JSONDecoder())
            .map { posts in
                posts.map { post in
                    var updatedPost = post
                    updatedPost.title = updatedPost.title.htmlToString()
                    updatedPost.content = updatedPost.content.htmlToString()
                    updatedPost.excerpt = updatedPost.excerpt.htmlToString()
                    return updatedPost
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// Holt Media-Daten für eine Liste von IDs parallel
    private func fetchMedia(for ids: [Int]) -> AnyPublisher<[MediaItem], Error> {
        let validIDs = ids.filter { $0 != 0 } // Keine 0er IDs anfragen
        
        let publishers = validIDs.map { id in
            let url = URL(string: "https://www.union-lasberg.at/wp-json/wp/v2/media/\(id)")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: MediaItem.self, decoder: JSONDecoder())
                .catch { error in
                    // Falls ein Fehler auftritt, geben wir einen leeren Publisher zurück,
                    // der den Fehler nicht durchlässt.
                    Just(MediaItem(id: -1, guid: RenderedText(rendered: ""))) // Optional: Fehlerobjekt zurückgeben
                        .setFailureType(to: Error.self) // Um den Fehler korrekt zu behandeln
                }
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(publishers) // Kombiniere alle Publisher
            .collect() // Sammle alle Ergebnisse
            .map { $0.compactMap { $0.id != -1 ? $0 : nil } } // Entferne Fehlerhafte Items
            .eraseToAnyPublisher() // Rückgabetyp korrekt auf AnyPublisher<[MediaItem], Error> setzen
    }
     */

}
