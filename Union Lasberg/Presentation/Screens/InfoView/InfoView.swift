//
//  InfoView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct InfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image("UL_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .shadow(radius: 5)
                .padding(.top)
            
            VStack(alignment: .center, spacing: 5) {
                Text("WIMBERGER Sportunion Lasberg")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Markt 26, 4291 Lasberg")
                Text("Österreich")
            }
            .foregroundStyle(Color.ulBlue)
            
            HStack(spacing: 20) {
                Link(destination: URL(string: "https://www.instagram.com/sportunion_lasberg/")!) {
                    SocialMediaButton(image: "instagram_logo")
                }
                Link(destination: URL(string: "https://www.facebook.com/unionlasberg/")!) {
                    SocialMediaButton(image: "facebook_logo")
                }
            }
            .padding()
            
            Spacer()
            
            Text("Sponsoren:")
                .fontWeight(.bold)
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading, .trailing])
            
            WebImage(url: URL(string: "https://www.union-lasberg.at/wp-content/uploads/2024/05/sponsorenslider_Union_2024.jpg"))
                .resizable()
                .indicator(.activity)
                .scaledToFit()
                .shadow(radius: 5)
                .padding([.bottom, .leading, .trailing])
        }
        .overlay(alignment: .topTrailing) {
            Button {
                dismiss()
            } label: {
                XDismissButton()
            }
        }
    }
}

#Preview {
    InfoView()
}
