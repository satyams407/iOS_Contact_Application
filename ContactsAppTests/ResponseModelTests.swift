//
//  ResponseModelTests.swift
//  ContactsAppTests
//
//  Created by Satyam Sehgal on 26/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
import Foundation

@testable import ContactsApp

struct MockContactModel: Codable  {
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

class ResponseModelTests: XCTestCase {
    var contactModel: MockContactModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        contactModel = nil
    }

    func testContactModelIntialisation() {
        let json: [String: Any] = [
            "id": 1,
            "first_name": "Amitabh",
            "last_name": "Bachchan",
            "email": "ab@bachchan.com",
            "phone_number": "+919980123412",
            "profile_pic": "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610",
            "favorite": false
        ]
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: json, options: [])
            contactModel = try JSONDecoder().decode(MockContactModel.self, from: data!)
            
            XCTAssertTrue(contactModel?.fullName == (contactModel!.firstName + " " + contactModel!.lastName), "Full Name intialised succesfully" )
        } catch {
            XCTFail("Fail to decode the model")
        }
        XCTAssertTrue(contactModel != nil, "Succesfully initialise the model")
    }
}
