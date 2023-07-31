//
//  SideMenuViewModel.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation

enum SideMenuViewModel : Int, CaseIterable {
    case my_letits
    case bookmarks
    case logout
    
    var title : String {
        switch self {
        case .my_letits: return "My Letits"
        case .bookmarks: return "Saved Letits"
        case .logout: return "Logout"
        }
    }
    
    var imageName : String {
        switch self {
        case .my_letits: return "list.bullet"
        case .bookmarks: return "bookmark"
        case .logout: return "arrow.left.square"
        }
    }
}
