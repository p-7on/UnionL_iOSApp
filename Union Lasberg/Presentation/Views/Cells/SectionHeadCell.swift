//
//  SectionHeadCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 21.03.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SectionHeadCell: View {
    
    @Environment(\.openURL) private var openURL
    
    let person: Person
    let category: FilterCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Unser Sektionsleiter")
                .foregroundStyle(Color.ulBlue)
                .font(.title3)
                .fontWeight(.semibold)
            HStack {
                WebImage(url: URL(string: person.imageURL))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 180, maxHeight: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Peter Lauritz")
                        .foregroundStyle(Color.ulBlue)
                        .font(.title3)
                    Button {
                        let urlString = "mailto:\(person.email)?subject=Anfrage Sektion \(category)"
                        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
                            openURL(url)
                        }
                    } label: {
                        HStack {
                            Text("Kontaktiere uns!")
                            Image(systemName: "envelope")
                        }
                        .fontWeight(.semibold)
    
                    }
                    .buttonStyle(.bordered)
                    .tint(Color.ulBlue)
                    .controlSize(.large)
                }
                .foregroundStyle(Color.ulBlue)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 180, maxHeight: 180)
            }

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 5)
        .padding([.leading, .trailing])
    }
}

#Preview {
    SectionHeadCell(person: MockDataPerson().mockPerson, category: .Fußball)
}
