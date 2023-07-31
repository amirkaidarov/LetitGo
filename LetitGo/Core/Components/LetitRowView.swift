//
//  LetitRowView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct LetitRowView: View {
    @ObservedObject var vm : LetitRowViewModel
    
    init(letit : Letit) {
        self.vm = LetitRowViewModel(letit: letit)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            if let user = vm.letit.user {
                HStack(alignment: .top, spacing:  12) {
//                    Circle()
//                        .frame(width: 56, height: 56)
                    VStack (alignment: .leading, spacing: 10) {
                        //user info
                        HStack {
                            Text("@\(user.username)")
                                .foregroundColor(Color(.gray))
                                .font(.caption)
                            Text(vm.getTimeAge())
                                .foregroundColor(Color(.gray))
                                .font(.caption)
                        }
                        
                        //tweet
                        Text(vm.letit.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        
            //action button
            HStack {
                Button {
                    vm.letit.didSave ?? false
                    ? vm.unsaveLetit()
                    : vm.saveLetit()
                } label: {
                    Image(systemName: vm.letit.didSave ?? false
                          ? "bookmark.fill"
                          : "bookmark")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                }
                Spacer()
                
                Group {
                    if vm.letit.likes > 0 {
                        Text(String(vm.letit.likes))
                            .font(.subheadline)
                            .foregroundColor(Color(.gray))
                    }
                    Button {
                        vm.letit.didLike ?? false
                        ? vm.unlikeLetit()
                        : vm.likeLetit()
                    } label: {
                        Image(systemName: vm.letit.didLike ?? false
                              ? "heart.fill"
                              : "heart")
                                .font(.subheadline)
                                .foregroundColor(vm.letit.didLike ?? false
                                                 ? .red
                                                 : .gray)
                    }
                }
            }
            .padding(.vertical)
            .foregroundColor(.gray)
            
            Divider()

        }.padding()
    }
}

//struct LetitRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        LetitRowView()
//    }
//}
