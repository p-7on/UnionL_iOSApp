//
//  HowItWorksCell.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 21.03.25.
//

import SwiftUI

struct HowItWorksCell: View {
    
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundStyle(Color.ulBlue)
                .font(.title3)
                .fontWeight(.semibold)
            Button {
                
            } label: {
                Text("So gehts!")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(Color.ulBlue)
            .controlSize(.large)
            .padding(.top)
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
    HowItWorksCell(title: "Du bist Fußballbegeistert und willst mitspielen?")
}
