//
//  HomeArticelCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import SwiftUI

struct HomePostCell: View {
    
    let date: Date
    let title: String
    let excerpt: String
    
    var body: some View {
        HStack {
            VStack {
                Text(date.filterDayFromDate())
                Text(date.filterMonthFromDate())
            }
            .foregroundStyle(Color.ulBlue)
            .font(.callout)
            .padding(.leading)
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .foregroundStyle(Color.ulBlue)
                    .font(.title3)
                    .fontWeight(.medium)
                    .lineLimit(2)
                Text(excerpt)
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                    .lineLimit(3)
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.ulBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 5)
        .padding([.leading, .trailing])
    }
}

#Preview {
    HomePostCell(date: Date(), title: "Bewegungsangebote starten bald!", excerpt: "Bald geht es wieder los und die Bewegungsangebote unserer Sektion Fitness&Bewegung gehen wieder los! Kosten der Bewegungsangebote: Saisonbeitrag (10x) für Union-Mitglieder...")
}
