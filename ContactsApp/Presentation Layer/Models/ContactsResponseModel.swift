//
//  ContactsResponseModel.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

typealias ContactResponseModel = [ContactResponseModelElement]

// MARK: ContactResponseModel
struct ContactResponseModelElement: Decodable {
    let model: Attributes
    let id: Int
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let singleValue = try decoder.singleValueContainer()
        id = try values.decode(Int.self, forKey: .id)
        createdAt = try? values.decode(String.self, forKey: .createdAt)
        updatedAt = try? values.decode(String.self, forKey: .updatedAt)
        model = try singleValue.decode(Attributes.self)
    }
}

extension ContactResponseModelElement {
    struct Attributes: Codable  {
        let firstName, lastName, profilePic: String
        let email, phoneNumber, url: String?
        let favorite: Bool
        
        var fullName: String {
            return [firstName, lastName].joined(separator: " ")
        }
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case email
            case phoneNumber = "phone_number"
            case profilePic = "profile_pic"
            case favorite, url
        }
    }
}

// MARK: Model used in post request for creation of new contact
struct ContactCreateModel: Encodable {
    let model: ContactResponseModelElement.Attributes
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ContactResponseModelElement.Attributes.CodingKeys.self)
        try container.encode(model.firstName, forKey: .firstName)
        try container.encode(model.lastName, forKey: .lastName)
        try container.encode(model.email, forKey: .email)
        try container.encode(model.profilePic, forKey: .profilePic)
        try container.encode(model.favorite, forKey: .favorite)
        try container.encode(model.phoneNumber, forKey: .phoneNumber)
    }
}

struct ContactUpdateModel: Encodable {
    let id: Int
    let model: ContactResponseModelElement.Attributes
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case profilePic = "profile_pic"
        case favorite, url
        case phoneNumber = "phone_number"
        case id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(model.firstName, forKey: .firstName)
        try container.encode(model.lastName, forKey: .lastName)
        try container.encode(model.email, forKey: .email)
        try container.encode(model.profilePic, forKey: .profilePic)
        try container.encode(model.favorite, forKey: .favorite)
        try container.encode(model.phoneNumber, forKey: .phoneNumber)
    }
}
