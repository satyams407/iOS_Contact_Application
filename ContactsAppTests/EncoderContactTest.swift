//
//  EncoderContactTest.swift
//  ContactsAppTests
//
//  Created by Satyam Sehgal on 26/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import ContactsApp

class EncoderContactTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncodeCreateModel() {
        let attributes = ContactResponseModelElement.Attributes.init(firstName: "satyam", lastName: "sehgal", profilePic: "/images/missing.png", email: "satyams407@gmail.com", phoneNumber: "9654759593", url: nil, favorite: false)
        
        let creationModel = ContactCreateModel.init(model: attributes)
        XCTAssertEqual(creationModel.model.firstName, "satyam")
        XCTAssertEqual(creationModel.model.lastName, "sehgal")
        XCTAssertEqual(creationModel.model.email, "satyams407@gmail.com")
        XCTAssertEqual(creationModel.model.phoneNumber, "9654759593")
    }
    
    func testEncodeUpdateModel() {
        let attributes = ContactResponseModelElement.Attributes.init(firstName: "satyam", lastName: "sehgal", profilePic: "/images/missing.png", email: "satyams407@gmail.com", phoneNumber: "9654759593", url: nil, favorite: false)
        
        let updateModel = ContactUpdateModel.init(id: 1, model: attributes)
        
        XCTAssertEqual(updateModel.model.firstName, "satyam")
        XCTAssertEqual(updateModel.model.lastName, "sehgal")
        XCTAssertEqual(updateModel.model.email, "satyams407@gmail.com")
        XCTAssertEqual(updateModel.model.phoneNumber, "9654759593")
        
    }
    
    
}
