//
//  CalendarView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import SwiftUI

struct CalendarView: View {
    
    @State var date = Date()
    let events = [
        Event(title: "Lasberg : Mauthausen", location: "Wimberger Arena Lasberg", date: Date.now, startTime: "16:30", endTime: "18:10"),
        Event(title: "Training", location: "Sportplatz", date: Date.now, startTime: "19:00", endTime: "20:30")]
    
    var body: some View {
        NavigationStack {
            VStack {
                    DatePicker("Start Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .tint(Color.ulRed)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 5, y: 5)
                        .padding([.leading, .trailing])
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding()
                
                
                ScrollView() {
                    Text("Veranstaltungen:")
                        .fontWeight(.bold)
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .trailing])
                    
                        ForEach(events, id: \.id) { event in
                            CalendarEventCell(event: event)
                        }
                }
                    
            }
            .navigationTitle("Kalender")
        }
        
    }
}

#Preview {
    CalendarView()
}
