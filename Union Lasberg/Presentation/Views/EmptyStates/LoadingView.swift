//
//  LoadingView.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 12.03.25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView().tint(Color.ulBlue)
            Text("Beiträge werden geladen...")
                .foregroundStyle(Color.ulBlue)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    LoadingView()
}
