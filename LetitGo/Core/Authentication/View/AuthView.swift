//
//  AuthView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        if viewModel.isLogin {
            LoginView()
                .navigationBarHidden(true)
        } else {
            RegistrationView()
                .navigationBarHidden(true)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
