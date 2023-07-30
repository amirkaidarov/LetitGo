//
//  LetitRowView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct LetitRowView: View {
    
    var body: some View {
        VStack (alignment: .leading) {
            
                HStack(alignment: .top, spacing:  12) {
                    Circle()
                        .frame(width: 56, height: 56)
                    VStack (alignment: .leading) {
                        //user info
                        HStack {
                            Text("Hello")
                                .font(.subheadline.bold())
                            Text("@name")
                                .foregroundColor(Color(.gray))
                                .font(.caption)
                            Text("2w")
                                .foregroundColor(Color(.gray))
                                .font(.caption)
                        }
                        
                        //tweet
                        Text("Hello World")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
        
            //action button
            HStack {
                Spacer()
                Button {
    
                } label: {
                    Image(systemName: "heart")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                }
            }
            .padding(.vertical)
            .foregroundColor(.gray)
            
            Divider()

        }.padding()
    }
}

struct LetitRowView_Previews: PreviewProvider {
    static var previews: some View {
        LetitRowView()
    }
}
