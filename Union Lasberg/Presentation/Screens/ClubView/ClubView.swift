//
//  ClubView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ClubView: View {
    
    @StateObject var viewModel = ClubViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.posts) { post in
                            NavigationLink(value: post) {
                                ClubPostCell(imageURL: post.imageURL,
                                             title: post.title,
                                             excerpt: post.excerpt)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding([.top, .bottom])
                }
                .refreshable {
                    viewModel.posts.removeAll()
                    viewModel.fetchClubPosts()
                }
                
                if viewModel.isLoading {
                    LoadingView()
                }
                    
            }
            .navigationTitle("Verein")
            .navigationDestination(for: Post.self) { post in
                HomePostDetailView(post: post)
            }
        }
        .alert(viewModel.alertItem?.title ?? Text("Error"), isPresented: $viewModel.isAlertShowing, presenting: viewModel.alertItem) { alertItem in
            Button("OK", role: .cancel) { viewModel.isAlertShowing = false }
        } message: { alertItem in
            alertItem.message
        }
    }
}

#Preview {
    ClubView()
}
