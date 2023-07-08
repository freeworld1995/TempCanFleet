//
//  Color+Extensions.swift
//  
//
//  Created by groo on 08/07/2023.
//

import SwiftUI

public extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    init(hex: String, opacity _: Double = 1.0) {
        let hex = Int(hex.replacingOccurrences(of: "#", with: ""), radix: 16) ?? 0
        self.init(hex: hex)
    }
}

public extension Color {
    static let mainBlack = Color(hex: "#2B3745")
    static let F9F9FC = Color(hex: "#F9F9FC")
    static let ECF2F8 = Color(hex: "#ECF2F8")
    static let mainOrange = Color(hex: "#ED6808")
}
