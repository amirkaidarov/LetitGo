//
//  User.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct User : Identifiable, Decodable {
    @DocumentID var id : String?
    let username : String
    let email : String
    
    var isCurrentUser : Bool {
        return Auth.auth().currentUser?.uid == id
    }
}

