//
//  ContactsResponseModel.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

// MARK: - ContactResponseModel
struct ContactResponseModelElement: Codable {
    let id: Int
    let firstName, lastName, profilePic: String
    let favorite: Bool
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite, url
    }
    
    var fullName: String {
        return firstName + " " + lastName
    }
}

typealias ContactResponseModel = [ContactResponseModelElement]
