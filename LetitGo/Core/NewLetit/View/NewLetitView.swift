//
//  NewLetitView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI
//import Kingfisher

struct NewLetitView: View {
    @State private var caption : String = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var letitVM = NewLetitViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(hex: 0x8559DC))
                }
                
                Spacer()
                
                Button {
                    letitVM.uploadLetit(withCaption:caption)
                } label: {
                    Text("Go")
                        .bold()
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(hex: 0x8559DC))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

            }
            .padding()
            
            HStack (alignment: .top ){
//                if let user = authViewModel.currentUser {
//                    KFImage(URL(string: user.profileImageURL))
//                        .resizable()
//                        .scaledToFill()
//                        .clipShape(Circle())
//                        .frame(width: 64, height: 64)
//                }
                
                TextArea("What's new?", text: $caption)
                
            }
            .padding()
        }
        .onReceive(letitVM.$didUploadLetit) { isSuccessful in
            if isSuccessful {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewLetitView_Previews: PreviewProvider {
    static var previews: some View {
        NewLetitView()
    }
}
