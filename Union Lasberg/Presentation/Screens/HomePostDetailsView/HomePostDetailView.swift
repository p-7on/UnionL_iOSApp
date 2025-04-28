//
//  HomePostDetailView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 12.03.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomePostDetailView: View {
    
    let post: Post
    
    var body: some View {
        ScrollView(.vertical) {
            WebImage(url: URL(string: post.imageURL ?? "https://www.union-lasberg.at/wp-content/uploads/2022/03/UL_Logo_original.png"))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                .shadow(radius: 5)
                .padding()
            
            VStack {
                Text(post.title)
                    .foregroundStyle(Color.ulRed)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                Text(post.content)
                    .padding()
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(item: URL(string: post.link)!) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
}

#Preview {
    HomePostDetailView(post: MockDataHomePost.sampleHomePost1)
}
