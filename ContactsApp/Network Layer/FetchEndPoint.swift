//
//  FetchEndPoint.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

// Can have mutilple cases for fetch request for different api calls
enum FetchEndPoint {
    case fetchContacts
    case fetchContact(id: Int)
    case createNewContact(model: ContactCreateModel)
    case updateContact(model: ContactUpdateModel)
}

extension FetchEndPoint {
    var baseURLPath: String {
        return "https://gojek-contacts-app.herokuapp.com/contacts"
    }
    
    var url: URL {
        guard let url = URL(string: path) else {
            fatalError(Constants.Errors.urlError)
        }
        return url
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchContact, .fetchContacts:
            return .get
        case .createNewContact:
            return .post
        case .updateContact:
            return .put
        }
    }
    
    var path: String {
        switch self {
        case .fetchContact(let id):
            return "\(baseURLPath)/\(id).json"
        case .fetchContacts, .createNewContact:
            return "\(baseURLPath).json"
        case .updateContact(let model):
            return "\(baseURLPath)/\(model.id).json"
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .fetchContact, .fetchContacts:
            return nil
        case .createNewContact(let contact):
            do {
                return try JSONEncoder().encode(contact)
            } catch {
                fatalError(Constants.Errors.deCodeError)
            }
        case .updateContact(let contact):
            do {
                return try JSONEncoder().encode(contact)
            } catch {
                fatalError(Constants.Errors.deCodeError)
            }
        }
    }
}
