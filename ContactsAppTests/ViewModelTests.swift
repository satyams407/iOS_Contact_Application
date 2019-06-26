//
//  ViewModelTests.swift
//  ContactsAppTests
//
//  Created by Satyam Sehgal on 26/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ViewModelTests: XCTestCase {
    var vm: UpdateAndEditViewModel?
    let validPhone = "1234567890"
    let validEmail = "satyams407@gmail.com"
    
    let inValidPhone = "213"
    let inValidEmail = "afafd.com"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = UpdateAndEditViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
    }

    func testEmailSuccess() {
      XCTAssertTrue(vm?.isValidEmailAddress(validEmail) ?? false)
    }
    func testEmailFailure() {
        XCTAssertTrue(!(vm?.isValidEmailAddress(inValidEmail) ?? false))
    }
    
    func testPhoneSuccess() {
        XCTAssertTrue(vm?.isValidPhoneNumber(validPhone) ?? false)
    }
    func testPhoneFailure() {
        XCTAssertTrue(!(vm?.isValidPhoneNumber(inValidPhone) ?? false))
    }
}
