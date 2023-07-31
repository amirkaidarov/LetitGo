//
//  NewLetitViewModel.swift
//  LetitGo
//
//  Created by Амир Кайдаров on 7/30/23.
//

import Foundation

class NewLetitViewModel : ObservableObject {
    let service = LetitService()
    @Published var didUploadLetit = false
    
    func uploadLetit(withCaption caption : String) {
        service.uploadLetit(caption: caption) { isSuccessful in
            self.didUploadLetit = isSuccessful
        }
    }
}
