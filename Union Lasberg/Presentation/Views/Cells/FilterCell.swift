//
//  FilterCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 18.03.25.
//

import SwiftUI

struct FilterCell: View {
    
    let filterCategory: FilterCategory
    @Binding var selectedFilter: FilterCategory
    
    var body: some View {
        Text(filterCategory.rawValue)
            .foregroundStyle(Color.ulBlue)
            .fontWeight(.semibold)
            .padding()
            .background(selectedFilter == filterCategory ? Color.ulRed : Color.ulBlue.opacity(0.1))
            .frame(height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: selectedFilter == filterCategory ? .black.opacity(0.3) : .black.opacity(0), radius: 5, x: 5, y: 5)
    }
}

#Preview {
    FilterCell(filterCategory: .Fußball, selectedFilter: .constant(.Tennis))
}
