//
//  FeedViewModel.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation


class FeedViewModel : ObservableObject {
    @Published var letits = [Letit]()
    @Published var myLetits = [Letit]()
    @Published var likedLetits = [Letit]()
    @Published var savedLetits = [Letit]()
    let user : User
    let service = LetitService()
    let userService = UserService()
    
    
    init(user: User) {
        self.user = user
        self.fetchLetits()
        self.fetchMyLetits()
        self.fetchLikedLetits()
        self.fetchSavedLetits()
    }
    
    func fetchFilteredLetits(for filter : LetitFilterViewModel) -> [Letit] {
        switch filter {
        case .all:
             return letits
        case .liked:
            return likedLetits
        case .my:
            return myLetits
        case .saved:
            return savedLetits
        }
    }
    
    private func fetchLetits() {
        service.fetchLetits { letits in
            self.letits = letits
            
            for i in 0..<letits.count {
                let uid = letits[i].uid
                self.userService.fetchUser(with: uid) { user in
                    self.letits[i].user = user
                }
            }
        }
    }
    
    func fetchMyLetits() {
        guard let uid = user.id else { return }
        
        service.fetchLetits(for: uid) { myLetits in
            self.myLetits = myLetits
            for i in 0..<myLetits.count{
                self.myLetits[i].user = self.user
            }
        }
    }
    
    func fetchLikedLetits(){
        guard let uid = user.id else { return }
        
        service.fetchLikedLetits(for: uid) { likedLetits in
            self.likedLetits = likedLetits
            
            for i in 0..<likedLetits.count {
                let uid = likedLetits[i].uid
                self.userService.fetchUser(with: uid) { user in
                    self.likedLetits[i].user = user
                }
            }
        }
    }
    
    func fetchSavedLetits(){
        guard let uid = user.id else { return }
        
        service.fetchSavedLetits(for: uid) { savedLetits in
            self.savedLetits = savedLetits
            
            for i in 0..<savedLetits.count {
                let uid = savedLetits[i].uid
                self.userService.fetchUser(with: uid) { user in
                    self.savedLetits[i].user = user
                }
            }
        }
    }
}

