//
//  HorizontalFilterView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 18.03.25.
//

import SwiftUI

struct HorizontalFilterView: View {
    
    @Binding var selectedItem: FilterCategory
    var items: [FilterCategory]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items, id: \.self) { item in
                    FilterCell(filterCategory: item, selectedFilter: $selectedItem)
                        .onTapGesture {
                            selectedItem = item
                        }
                }
            }
            .padding([.leading, .trailing, .bottom])
        }
    }
}

#Preview {
    HorizontalFilterView(selectedItem: .constant(.Fußball), items: [.Fußball, .Tennis, .FitnessBewegung, .Laufen])
}
