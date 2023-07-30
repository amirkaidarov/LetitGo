//
//  LoginView.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
//    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        VStack {
            //header view
            AuthHeaderView()
             
            VStack (spacing: 40) {
                CustomInputField (imageName : "envelope",
                                  placeholderText: "Email",
                                  text : $email)
                CustomInputField (imageName : "lock",
                                  placeholderText: "Password",
                                  isSecureField: true,
                                  text : $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                NavigationLink {
                    Text("Reset Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: 0xB452B1))
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            
            Button {
//                viewModel.login(withEmail: email, andPassword: password)
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(hex: 0xB452B1))
                    .clipShape(Capsule()
                    )
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding(.top)

            
            Spacer()
            
            Button {

//                viewModel.toggleIsLogin()
                
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                    Text("Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(Color(hex: 0xB452B1))

                
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
