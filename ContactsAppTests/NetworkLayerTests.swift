//
//  NetworkLayerTests.swift
//  ContactsAppTests
//
//  Created by Satyam Sehgal on 26/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import ContactsApp

class MockFetchContactService: FetchContactsServiceProtocol {
    var responseContactsJSONString: [[String: Any]]?
    func fetchContacts(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModel, APIServiceError>) -> Void) {
        guard let responseString = responseContactsJSONString, let data = try? JSONSerialization.data(withJSONObject: responseString, options: []) else {
            completionHandler(.failure(.fetchError))
            return
        }
        guard let responseModel = try? JSONDecoder().decode(ContactResponseModel.self, from: data) else {
            completionHandler(.failure(.decodeError))
            return
        }
        completionHandler(.success(responseModel))
    }
    
    var responseContactJSONString: [String: Any]?
    func fetchContact(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModelElement, APIServiceError>) -> Void) {
        guard let responseString = responseContactJSONString, let data = try? JSONSerialization.data(withJSONObject: responseString, options: []) else {
            completionHandler(.failure(.fetchError))
            return
        }
        guard let responseModel = try? JSONDecoder().decode(ContactResponseModelElement.self, from: data) else {
            completionHandler(.failure(.decodeError))
            return
        }
        completionHandler(.success(responseModel))
    }
    
    func createOrUpdateContact(with endPoint: FetchEndPoint, completionHandler: @escaping (Result<ContactResponseModelElement, APIServiceError>) -> Void) {
        // Simlarly as above, we can test this 
    }
}

class NetworkLayerTests: XCTestCase {
    var mockFetchContactService: MockFetchContactService?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockFetchContactService = nil
    }
    
    func testfetchContactsSuccess() {
        mockFetchContactService?.responseContactsJSONString = [
            ["id":6241,"first_name":"First","last_name":"Last","profile_pic":"/images/missing.png","favorite":false,"url":"https://gojek-contacts-app.herokuapp.com/contacts/6241.json"],["id":6238,"first_name":"First","last_name":"Last","profile_pic":"/images/missing.png","favorite":false,"url":"https://gojek-contacts-app.herokuapp.com/contacts/6238.json"]
        ]
        mockFetchContactService?.fetchContacts(with: .fetchContacts, completionHandler: { result in
            var isNetWorkResultSuccess = false
            switch result {
            case .success(_):
                isNetWorkResultSuccess = true
            case .failure(_):
                isNetWorkResultSuccess = false
            }
            XCTAssert(isNetWorkResultSuccess == true , "Successfully")
        })
    }
    
    func testFetchContactsServiceFailure() {
        mockFetchContactService?.responseContactsJSONString = nil
        mockFetchContactService?.fetchContacts(with: .fetchContacts) { (result) in
            var networkFailureError : APIServiceError?
            switch result {
            case .success(_):
                networkFailureError = nil
            case .failure(let error):
                networkFailureError = error
            }
            XCTAssert(networkFailureError == APIServiceError.fetchError , "Failed")
        }
    }
    
    func testFetchContactWithId() {
        mockFetchContactService?.responseContactJSONString = ["id":6241,"first_name":"First","last_name":"Last","profile_pic":"/images/missing.png","favorite":false,"url":"https://gojek-contacts-app.herokuapp.com/contacts/6241.json"]
        
        mockFetchContactService?.fetchContact(with: .fetchContact(id:6241), completionHandler: { result in
            var isNetWorkResultSuccess = false
            switch result {
            case .success(_):
                isNetWorkResultSuccess = true
            case .failure(_):
                isNetWorkResultSuccess = false
            }
            XCTAssert(isNetWorkResultSuccess == true , "Successfully")
        })
    }
    
    func testPaths() {
        let fetchContact = FetchEndPoint.fetchContact(id: 1)
        let contactPath = fetchContact.baseURLPath + fetchContact.path
        XCTAssertEqual(contactPath, "https://gojek-contacts-app.herokuapp.com/contactshttps://gojek-contacts-app.herokuapp.com/contacts/1.json")
        
        let fetchContacts = FetchEndPoint.fetchContacts
        let contactsPath = fetchContacts.baseURLPath + fetchContacts.path
        XCTAssertEqual(contactsPath,"https://gojek-contacts-app.herokuapp.com/contactshttps://gojek-contacts-app.herokuapp.com/contacts.json")
    }
}
