//
//  LetitService.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation

import Firebase


struct LetitService {
    
    func getTimeAge(timestamp : Timestamp) -> String {
        let date = timestamp.dateValue()
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.locale = Locale(identifier: "en_US")
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    func uploadLetit(caption : String, completion : @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes" : 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("letits")
            .document()
            .setData(data) { error in
                if let error = error {
                    completion(false)
                    print("failed to upload tweet: \(error)")
                    return
                }
                
                completion(true)
                
            }
    }
    
    func fetchLetits(completion : @escaping([Letit]) -> Void) {
        Firestore.firestore().collection("letits")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener({ collectionSnapshot, _ in
                guard let documents = collectionSnapshot?.documents else { return }
                let letits = documents.compactMap({ try? $0.data(as: Letit.self)})

                completion(letits)
            })
//            .getDocuments { snapshot, _ in
//                guard let documents = snapshot?.documents else { return }
//
//                let letits = documents.compactMap({ try? $0.data(as: Letit.self)})
//
//                completion(letits)
//            }
    }
    
    func fetchLetits(for uid : String, completion : @escaping([Letit]) -> Void) {
        Firestore.firestore().collection("letits")
            .whereField("uid", isEqualTo: uid)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener({ collectionSnapshot, _ in
                guard let documents = collectionSnapshot?.documents else { return }
                let letits = documents.compactMap({ try? $0.data(as: Letit.self)})

                completion(letits)
            })
//            .getDocuments { snapshot, _ in
//                guard let documents = snapshot?.documents else { return }
//
//                let tweets = documents.compactMap({ try? $0.data(as: Letit.self)})
//
//                completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
//            }
    }
    
}

//MARK: - Likes

extension LetitService {
    
    func likeLetit(_ letit : Letit, completion : @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let letitId = letit.id else { return }
        
        let userLikesRef =  Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
        
        Firestore.firestore().collection("letits")
            .document(letitId)
            .updateData(["likes" : letit.likes + 1]) { _ in
                userLikesRef
                    .document(letitId)
                    .setData([:]) { _ in
                        completion()
                    }
                    
            }
    }
    
    func checkIfUserLikedLetit(_ letit : Letit, completion : @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let letitId = letit.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(letitId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func unlikeLetit(_ letit : Letit, completion : @escaping() -> Void ){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let letitId = letit.id else { return }
        
        guard letit.likes > 0 else { return }
        
        let userLikesRef =  Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
        
        Firestore.firestore().collection("letits")
            .document(letitId)
            .updateData(["likes" : letit.likes - 1]) { _ in
                userLikesRef
                    .document(letitId)
                    .delete() { _ in
                        completion()
                    }
                    
            }
    }
    
    func fetchLikedLetits(for uid : String, completion : @escaping([Letit]) -> Void ) {
        var letits = [Letit]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
//            .order(by: "timestamp", descending: true)
//            .addSnapshotListener({ collectionSnapshot, _ in
//                guard let documents = collectionSnapshot?.documents else { return }
//                documents.forEach { document in
//                    let letitID = document.documentID
//                    Firestore.firestore().collection("letits")
//                        .document(letitID)
//                        .getDocument { snapshot, error in
//                            guard let letit = try? snapshot?.data(as : Letit.self) else { return }
//                            letits.append(letit)
//                            completion(letits)
//                        }
//                }
//            })
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { document in
                    let letitID = document.documentID
                    Firestore.firestore().collection("letits")
                        .document(letitID)
                        .getDocument { snapshot, error in
                            guard let letit = try? snapshot?.data(as : Letit.self) else { return }
                            letits.append(letit)
                            completion(letits)
                        }
                }
            }
    }
}


//MARK: - Saves

extension LetitService {
    
    func saveLetit(_ letit : Letit, completion : @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let letitId = letit.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saves")
            .document(letitId)
            .setData([:]) { _ in
                completion()
            }
    }
    
    func checkIfUserSavedLetit(_ letit : Letit, completion : @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let letitId = letit.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saves")
            .document(letitId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func unsaveLetit(_ letit : Letit, completion : @escaping() -> Void ){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let letitId = letit.id else { return }
        
        guard letit.likes > 0 else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saves")
            .document(letitId)
            .delete() { _ in
                completion()
            }
    }
    
    func fetchSavedLetits(for uid : String, completion : @escaping([Letit]) -> Void ) {
        var letits = [Letit]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saves")
//            .order(by: "timestamp", descending: true)
//            .addSnapshotListener({ collectionSnapshot, _ in
//                guard let documents = collectionSnapshot?.documents else { return }
//                documents.forEach { document in
//                    let letitID = document.documentID
//                    Firestore.firestore().collection("letits")
//                        .document(letitID)
//                        .getDocument { snapshot, error in
//                            guard let letit = try? snapshot?.data(as : Letit.self) else { return }
//                            letits.append(letit)
//                            completion(letits)
//                        }
//                }
//            })
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                documents.forEach { document in
                    let letitID = document.documentID
                    Firestore.firestore().collection("letits")
                        .document(letitID)
                        .getDocument { snapshot, error in
                            guard let letit = try? snapshot?.data(as : Letit.self) else { return }
                            letits.append(letit)
                            completion(letits)
                        }
                }
            }
    }
}

