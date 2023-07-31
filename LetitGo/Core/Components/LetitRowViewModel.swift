//
//  LetitRowViewModel.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation
import Firebase

class LetitRowViewModel : ObservableObject {
    private let service = LetitService()
    
    @Published var letit : Letit
    
    init(letit : Letit) {
        self.letit = letit
        checkIfUserLikedLetit(letit)
        checkIfUserSavedLetit(letit)
    }
    
    func likeLetit(){
        service.likeLetit(letit) {
            self.letit.didLike = true
        }
    }
    
    func unlikeLetit() {
        service.unlikeLetit(letit) {
            self.letit.didLike = false
        }
    }
    
    func checkIfUserLikedLetit(_ letit : Letit) {
        service.checkIfUserLikedLetit(letit) { didLike in
            self.letit.didLike = didLike
        }
    }
    
    func saveLetit(){
        service.saveLetit(letit) {
            self.letit.didSave = true
        }
    }
    
    func unsaveLetit() {
        service.unsaveLetit(letit) {
            self.letit.didSave = false
        }
    }
    
    func checkIfUserSavedLetit(_ letit : Letit) {
        service.checkIfUserSavedLetit(letit) { didSave in
            self.letit.didSave = didSave
        }
    }
    
    func getTimeAge() -> String {
        return service.getTimeAge(timestamp: self.letit.timestamp)
    }
        
}
