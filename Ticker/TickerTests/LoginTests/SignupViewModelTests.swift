//
//  SignupViewModelTests.swift
//  TickerTests
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import XCTest
@testable import Ticker

class SignupViewModelTests: XCTestCase {
    var signupViewModel: SignupViewModel!
    
    override func setUp() {
        signupViewModel = SignupViewModel()
    }

    override func tearDown() {
    }

    func testSignupValidationError() {
        let invalidInputs = ["First name", "Last name", "Email address", "Password"]
        let errorMessage = signupViewModel.getSignupValidationError(invalidInputs: invalidInputs)
        XCTAssert(errorMessage == "Please enter valid First name, Last name, Email address, Password.")
    }
    
    func testIsInputValid() {
        
    }
}
