//
//  XDismissButton.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 17.03.25.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .tint(Color.ulBlue)
                .frame(width: 30, height: 30)
                .opacity(0.2)
            Image(systemName: "xmark")
                .tint(Color.ulBlue)
                .imageScale(.medium)
        }
        .padding()
    }
}

#Preview {
    XDismissButton()
}
