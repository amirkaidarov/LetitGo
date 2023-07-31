//
//  UserService.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(with uid : String, completion : @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                guard let snapshot = snapshot else { return }
                guard let user  = try? snapshot.data(as: User.self) else { return }
                
                completion(user)
            }
    }
    
//    func fetchUsers(completion : @escaping([User]) -> Void) {
//        var users = [User]()
//        Firestore.firestore().collection("users")
//            .getDocuments { snapshot, _ in
//                guard let documents = snapshot?.documents else { return }
//
//                documents.forEach { document in
//                    guard let user = try? document.data(as : User.self) else { return }
//                    users.append(user)
//                }
//
//                completion(users)
//            }
//    }
}

