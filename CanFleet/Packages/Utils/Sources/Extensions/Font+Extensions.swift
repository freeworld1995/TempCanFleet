//
//  Font+Extensions.swift
//  
//
//  Created by Jimmy on 08/07/2023.
//

import SwiftUI

public extension Font {
    static func poppinsBold(size: CGFloat) -> Font {
        Font.custom("Poppins-Bold", size: size, relativeTo: .body)
    }
    static func poppinsRegular(size: CGFloat) -> Font {
        Font.custom("Poppins-Regular", size: size, relativeTo: .body)
    }
}
