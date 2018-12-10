//
//  ValidationUtilityTests.swift
//  TickerTests
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import XCTest
@testable import Ticker

class ValidationUtilityTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testIsValidName() {
        var isValid = ValidationUtility.isValidName("")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidName("Smitha")
        XCTAssertTrue(isValid)
    }
    
    func testIsValidEmail() {
        var isValid = ValidationUtility.isValidEmail("smitha@gmail")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidEmail("smitha")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidEmail(nil)
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidEmail("smitha@gmail.com")
        XCTAssertTrue(isValid)
    }
    
    func testIsValidPassword() {
        var isValid = ValidationUtility.isValidPassword("pass")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidPassword("pass1234")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidPassword("pass12!")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidPassword("pass!@#$")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidPassword(nil)
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidPassword("Qwertyuiop123456")
        XCTAssertFalse(isValid)
        isValid = ValidationUtility.isValidPassword("Qwerty12!")
        XCTAssertTrue(isValid)
    }
}
