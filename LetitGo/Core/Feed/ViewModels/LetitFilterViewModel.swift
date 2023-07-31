//
//  LetitFilterViewModel.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation

enum LetitFilterViewModel : Int, CaseIterable {
    case all
    case my
    case saved
    case liked
    
    var title : String {
        switch self{
        case .all: return "All"
        case .my: return "My"
        case .saved: return "Saved"
        case .liked: return "Liked"
        }
    }
}
