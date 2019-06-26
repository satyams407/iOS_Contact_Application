//
//  ContactListCellModel.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct ContactListCellModel {
    let imageUrl: String
    let name: String
    let isFavorite: Bool
    
    init(with model: ContactResponseModelElement) {
        self.name = model.fullName
        self.imageUrl = model.profilePic
        self.isFavorite = model.favorite
    }
}
