//
//  UniversalButton.swift
//  CanFleet
//
//  Created by groo on 08/07/2023.
//

import SwiftUI

struct UniversalButton: View {
    let title: String
    let action: (() -> Void)
    var body: some View {
        Button(
            title,
            action: action
        )
        .frame(height: 64)
        .frame(maxWidth: .infinity)
        .font(.poppinsBold(size: 20))
        .foregroundColor(.white)
        .background( // Background color
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.mainOrange)
        )
    }
}

struct UniversalButton_Previews: PreviewProvider {
    static var previews: some View {
        UniversalButton(title: "Login") {
            
        }
        .padding(.horizontal, 16)
    }
}
