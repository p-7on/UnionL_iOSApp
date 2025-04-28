//
//  SocialMediaButton.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import SwiftUI

struct SocialMediaButton: View {
    
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 50, height: 50)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
    }
}

#Preview {
    SocialMediaButton(image: "facebook_logo")
}
