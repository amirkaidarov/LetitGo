//
//  AuthViewModel.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


class AuthViewModel : ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var isLogin = true
    @Published var currentUser : User?

    private let service = UserService()

    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func toggleIsLogin() {
        isLogin.toggle()
    }

    func login(withEmail email : String, andPassword password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            self.userSession = result?.user
            self.fetchUser()
        }
    }

    func register(email : String, password : String, username : String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let user = result?.user else { return }

            self.userSession = user

            let data = ["email": email,
                        "username": username.lowercased(),
                        "uid" : user.uid]

            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }

        }
    }

    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }

    private func fetchUser() {
        if let uid = userSession?.uid {
            service.fetchUser(with: uid) { user in
                self.currentUser = user
            }
        }
    }
}

