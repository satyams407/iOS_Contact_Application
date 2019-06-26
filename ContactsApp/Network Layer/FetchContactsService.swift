//
//  FetchContactsService.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

struct FetchContactService: FetchContactsServiceProtocol {
  
    
    func fetchContacts(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModel,APIServiceError>) -> Void) {
        NetworkRequest.sharedInstance.executeRequest(buildRequest(endPoint: endPoint)) { result in
            switch result {
            case.failure(let apiError) :
                completionHandler(.failure(apiError))
            case .success(let data):
                if let contactsResponseModel = try? JSONDecoder().decode(ContactResponseModel.self, from: data) {
                    completionHandler(.success(contactsResponseModel))
                } else {
                    completionHandler(.failure(.decodeError))
                }
            }
        }
    }
    
    func fetchContact(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModelElement,APIServiceError>) -> Void) {
        NetworkRequest.sharedInstance.executeRequest(buildRequest(endPoint: endPoint)) { result in
            switch result {
            case.failure(let apiError) :
                completionHandler(.failure(apiError))
            case .success(let data):
                if let contactResponseModelElement = try? JSONDecoder().decode(ContactResponseModelElement.self, from: data) {
                    completionHandler(.success(contactResponseModelElement))
                } else {
                    completionHandler(.failure(.decodeError))
                }
            }
        }
    }
    
    func createOrUpdateContact(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModelElement, APIServiceError>) -> Void) {
        NetworkRequest.sharedInstance.executeRequest(buildRequest(endPoint: endPoint)) {  result in
            switch result {
            case.failure(let apiError) :
                completionHandler(.failure(apiError))
            case .success(let data):
                if let contactResponseModelElement = try? JSONDecoder().decode(ContactResponseModelElement.self, from: data) {
                    completionHandler(.success(contactResponseModelElement))
                } else {
                    completionHandler(.failure(.decodeError))
                }
            }
        }
    }
    
}
