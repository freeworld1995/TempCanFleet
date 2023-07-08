//
//  SwiftUIView.swift
//  
//
//  Created by Jimmy on 08/07/2023.
//

import SwiftUI
import Utils

public struct UniversalTextfield: View {
    public enum TextfieldType {
        case `default`
        case secure
    }
    
    private enum Field {
        case textField
    }
    
    private let title: String
    private let type: TextfieldType
    
    @Binding private var text: String
    @Binding private var valid: Bool
    @Binding private var hint: String
    
    @FocusState private var focusField: Field?
    
    @State private var isShowingPasswordField = true
    @State private var borderColor = Color.ECF2F8
    @State private var borderWidth = 1.0
    
    // MARK: Initialize
    
    public init(
        title: String,
        type: TextfieldType,
        text: Binding<String>,
        valid: Binding<Bool>,
        hint: Binding<String>
    ) {
        self.title = title
        self.type = type
        self._isShowingPasswordField = .init(initialValue: type == .default)
        self._text = text
        self._valid = valid
        self._hint = hint
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                VStack(alignment: .center) {
                    HStack(spacing: 0) {
                        if type == .secure && !isShowingPasswordField {
                            SecureField("", text: $text)
                                .padding(.leading, 16)
                                .focused($focusField, equals: .textField)
                        } else {
                            TextField("", text: $text)
                                .padding(.leading, 16)
                                .focused($focusField, equals: .textField)
                        }
                        if type == .secure {
                            Image(isShowingPasswordField ? "password-eye-open" : "password-eye-close", bundle: .main)
                                .frame(width: 18, height: 16)
                                .onTapGesture {
                                    isShowingPasswordField.toggle()
                                }
                                .padding(.trailing, 16)
                        }
                    }
                }
                .frame(height: 50) // Height
                .background( // Background color
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.F9F9FC)
                )
                .overlay( // Border
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: borderWidth)
                        .strokeBorder(borderColor, lineWidth: borderWidth)
                )
                if !hint.isEmpty {
                    Text(hint)
                        .foregroundColor(.red)
                }
            }
        }
        .font(.poppinsRegular(size: 14))
    }
}

struct UniversalTextfield_Previews: PreviewProvider {
    static var previews: some View {
        Preview(devices: [.iphone14]) {
            VStack {
                UniversalTextfield(title: "Phone Number",
                                   type: .default,
                                   text: .constant("12345678"),
                                   valid: .constant(true),
                                   hint: .constant("Please enter correct phone number"))
                .padding(.horizontal, 16)
                
                Spacer().frame(height: 16)
                
                UniversalTextfield(title: "Password",
                                   type: .secure,
                                   text: .constant("12345678"),
                                   valid: .constant(true),
                                   hint: .constant(""))
                .padding(.horizontal, 16)
            }
        }
    }
}
