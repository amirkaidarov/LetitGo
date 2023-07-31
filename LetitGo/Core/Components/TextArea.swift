//
//  TextArea.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct TextArea: View {
    
    @Binding var text : String
    
    let placeholder : String
    
    init(_ placeholder : String, text : Binding<String>){
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().tintColor = UIColorFromHex(hex: 0x8559DC)
        
    }
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            TextEditor(text: $text)
                .padding(4)

            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            
        }
        .font(.body)
    }
    
    func UIColorFromHex(hex: UInt32) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

