//
//  Letit.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Letit : Identifiable, Decodable{
    @DocumentID var id : String?
    let caption : String
    let timestamp : Timestamp
    let uid : String
    var likes : Int
    
    var user : User?
    var didLike : Bool?
    var didSave : Bool?
}

