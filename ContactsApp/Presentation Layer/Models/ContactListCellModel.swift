//
//  ContactListCellModel.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct ContactListCellModel {
    let imageUrl, name: String
    let isFavorite: Bool
    let id: Int
    
    init(with contact: ContactResponseModelElement) {
        self.name = contact.model.fullName
        self.imageUrl = contact.model.profilePic
        self.isFavorite = contact.model.favorite
        self.id = contact.id
    }
}
