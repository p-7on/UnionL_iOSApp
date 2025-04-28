//
//  SectionView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import SwiftUI

struct SectionView: View {
    
    @StateObject var viewModel = SectionViewModel()
    
    var body: some View {
        NavigationStack {
                ScrollView(.vertical) {
                    HorizontalFilterView(selectedItem: $viewModel.selectedCategory, items: viewModel.sections)
                        .zIndex(1)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Willkommen bei der Sektion \(viewModel.selectedCategory) der Sportunion Lasberg!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom)
                            .padding([.leading, .trailing])
                        
                        NextEventCell(event: Event(title: "Lasberg : Mauthausen", date: Date.now, startTime: "16:30", endTime: "18:10"))
                        SectionHeadCell(person: MockDataPerson().mockPerson, category: viewModel.selectedCategory)
                        HowItWorksCell(title: "Du bist in \(viewModel.selectedCategory) begeistert und willst mitmachen?")
                        HowItWorksCell(title: "Du willst Teil der Union-Familie werden?")
                        
                        
                        
                    }
                    .padding(.bottom)
                    
                    LazyVStack(spacing: 10) {
                        Text("Neuigkeiten der Sektion:")
                            .fontWeight(.bold)
                            .foregroundStyle(.accent)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.leading, .trailing])
                        
                        if viewModel.isLoading {
                            LoadingView()
                                .padding([.top, .bottom], 50)
                        }
                        
                        switch viewModel.selectedCategory {
                        case .Fußball:
                            ForEach(viewModel.soccerPosts) { post in
                                NavigationLink(value: post) {
                                    ClubPostCell(imageURL: post.imageURL, title: post.title, excerpt: post.excerpt)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        case .Tennis:
                            ForEach(viewModel.tennisPosts) { post in
                                NavigationLink(value: post) {
                                    ClubPostCell(imageURL: post.imageURL, title: post.title, excerpt: post.excerpt)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        case .FitnessBewegung:
                            ForEach(viewModel.fitnessPosts) { post in
                                NavigationLink(value: post) {
                                    ClubPostCell(imageURL: post.imageURL, title: post.title, excerpt: post.excerpt)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        case .Laufen:
                            ForEach(viewModel.runningPosts) { post in
                                NavigationLink(value: post) {
                                    ClubPostCell(imageURL: post.imageURL, title: post.title, excerpt: post.excerpt)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .coordinateSpace(name: "MainScrollView")
    
                
            .navigationTitle("Sektionen")
            .navigationDestination(for: Post.self) { post in
                HomePostDetailView(post: post)
            }
        }
    }
}

#Preview {
    SectionView()
}
