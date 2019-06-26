//
//  FetchContactsServiceProtocol.swift
//  ContactsApp
//
//  Created by Satyam Sehgal on 23/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import Foundation

protocol FetchContactsServiceProtocol {
    func fetchContacts(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModel,APIServiceError>) -> Void)
    func fetchContact(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModelElement,APIServiceError>) -> Void)
    func createOrUpdateContact(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModelElement, APIServiceError>) -> Void)
}

extension FetchContactsServiceProtocol {
    func buildRequest(endPoint: FetchEndPoint) -> URLRequest {
        var request = URLRequest(url: endPoint.url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        request.httpMethod = endPoint.httpMethod.rawValue
        request.httpBody = endPoint.httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
