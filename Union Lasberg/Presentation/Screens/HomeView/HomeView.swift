//
//  HomeView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        // Large Navigation Title
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.ulBlue]
        // Inline Navigation Title
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.ulBlue]
    }
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image("UL_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .shadow(radius: 5)
                    Text("Aktuelle Beiträge:")
                        .fontWeight(.bold)
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .trailing])
                }
                
                if viewModel.isLoading {
                    LoadingView().padding(.top, 150)
                }
                
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.posts) { post in
                        NavigationLink(value: post) {
                            HomePostCell(date: post.date,
                                         title: post.title,
                                         excerpt: post.excerpt)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle("Home")
            .background(Color.ulBackground)
            .navigationDestination(for: Post.self, destination: { post in
                HomePostDetailView(post: post)
            })
            .refreshable {
                viewModel.posts.removeAll()
                viewModel.fetchHomePosts()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showInfoView = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(Color.ulBlue)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showInfoView) {
                InfoView()
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
    HomeView()
}
