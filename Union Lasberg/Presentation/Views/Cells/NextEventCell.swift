//
//  NextEventCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 21.03.25.
//

import SwiftUI

struct NextEventCell: View {
    
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Nächster Termin der Sektion")
                .foregroundStyle(Color.ulBlue)
                .font(.title3)
                .fontWeight(.semibold)
            Text("🗓️ " + event.title)
                .foregroundStyle(Color.secondary)
                .font(.title3)
                .lineLimit(1)
            Text(event.date.dateShort() + " " + event.startTime + " - " + event.endTime)
                .foregroundStyle(Color.ulBlue)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.ulBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 5)
        .padding([.leading, .trailing])
    }
}

#Preview {
    
    let customDate = Calendar.current.date(from: DateComponents(year: 2025, month: 3, day: 22)) ?? Date()
    
    NextEventCell(event: Event(title: "Lasberg : Mauthausen", date: customDate, startTime: "16:30", endTime: "18:10"))
}
