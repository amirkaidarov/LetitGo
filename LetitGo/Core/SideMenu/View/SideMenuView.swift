//
//  SideMenuView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var vm : AuthViewModel
    
    var body: some View {
        if let user = vm.currentUser {
            VStack (alignment: .leading, spacing : 32){
                VStack (alignment: .leading){
                    Text("@\(user.username)")
                        .font(.headline)
                        .foregroundColor(Color(.black))
                        .padding(.vertical)
                    
//                    UserStatsView()
//                        .padding(.vertical)
                }
                .padding(.leading)
                
                ForEach( SideMenuViewModel.allCases, id : \.rawValue) { viewModel in
                    if viewModel == .logout {
                        Button{
                            self.vm.signOut()
                        } label : {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                    } else {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                }
                
                Spacer()
            }
        } else {
            Spacer()
        }
        
        
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
