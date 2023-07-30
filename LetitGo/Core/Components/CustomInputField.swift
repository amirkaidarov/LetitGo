//
//  CustomInputField.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct CustomInputField: View {
    
    let imageName : String
    let placeholderText : String
    var isSecureField : Bool = false
    
    @Binding var text : String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
            }
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputFields_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                         placeholderText: "Email",
                         text: .constant(""))
    }
}
