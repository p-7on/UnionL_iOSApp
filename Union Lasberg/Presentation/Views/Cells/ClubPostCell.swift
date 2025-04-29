//
//  ClubPostCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ClubPostCell: View {
    
    let imageURL: String?
    let title: String
    let excerpt: String
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: imageURL ?? "https://www.union-lasberg.at/wp-content/uploads/2022/03/UL_Logo_original.png"))
                .resizable()
                .indicator(.activity)
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                .clipped()
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .foregroundStyle(Color.ulBlue)
                    .font(.title3)
                    .fontWeight(.medium)
                    .lineLimit(1)
                Text(excerpt)
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                    .lineLimit(3)
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color.ulBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 5)
        .padding([.leading, .trailing])
    }
}

#Preview {
    ClubPostCell(imageURL: "https://www.union-lasberg.at/wp-content/uploads/2024/09/20240922_175916.png", title: "Abschied unserer Nummer 7 Tomas Lestina", excerpt: "178 Tore, 136 Siege, 300 Spiele und 25179 Einsatzminuten das ist die unglaubliche Bilanz von Tomas Lestina #7 bei der Sportunion Lasberg. Doch Lesti war viel mehr als nur")
}
