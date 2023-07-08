//
//  Preview.swift
//  
//
//  Created by Jimmy on 08/07/2023.
//

import SwiftUI

public struct Preview<Content: View>: View {
    
    public enum DeviceType {
        case iphone14
        case iphone14Plus
        case iphoneSE
        
        var name: String {
            switch self {
            case .iphone14:
                return "iPhone 14"
            case .iphone14Plus:
                return "iPhone 14 Plus"
            case .iphoneSE:
                return "iPhone SE"
            }
        }
        
        var previewDevice: String {
            switch self {
            case .iphone14:
                return "iPhone 14"
            case .iphone14Plus:
                return "iPhone 14 Plus"
            case .iphoneSE:
                return "iPhone SE (3rd generation)"
            }
        }
    }
    
    let content: Content
    let devices: [DeviceType]
    
    public init(devices: [DeviceType], @ViewBuilder _ content: () -> Content) {
        self.devices = devices
        self.content = content()
    }
    
    public var body: some View {
        ForEach(devices, id: \.previewDevice) { deviceType in
            content
                .previewDevice(PreviewDevice(rawValue: deviceType.previewDevice))
                .previewDisplayName(deviceType.name)
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14, .iphoneSE, .iphone14Plus]) {
            Text("Hello")
        }
    }
}

