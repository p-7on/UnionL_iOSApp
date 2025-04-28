//
//  CalendarEventCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 13.03.25.
//

import SwiftUI

struct CalendarEventCell: View {
    
    let event: Event
    
    var body: some View {
        HStack {
            Capsule()
                .fill(Color.ulRed)
                .frame(width: 4, height: 50, alignment: .leading)
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(event.title)
                    .bold()
                Text("📍 " + (event.location ?? ""))
            }
            Spacer()
            VStack {
                Text(event.startTime)
                Text(event.endTime)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 20, x: 5, y: 5)
        .padding([.leading, .trailing])
    }
}

#Preview {
    CalendarEventCell(event: Event(title: "Lasberg : Mauthausen", location: "Wimberger Arena Lasberg", date: Date.now, startTime: "16:30", endTime: "18:10"))
}
