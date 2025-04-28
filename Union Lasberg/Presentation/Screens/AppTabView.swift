//
//  ContentView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 11.03.25.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Verein", systemImage: "newspaper") {
                ClubView()
            }
            Tab("Sektion", systemImage: "figure.run") {
                SectionView()
            }
            Tab("Kalender", systemImage: "calendar") {
                CalendarView()
            }
        }
        .tint(Color.ulBlue)
    }
}

#Preview {
    AppTabView()
}
