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
        //Invalid input test
        var isValid = signupViewModel.isInputValid(signupInput: SignupInputModel(firstName: nil,
                                                                                 lastName: nil,
                                                                                 emailID: nil,
                                                                                 password: nil))
        XCTAssert(isValid.0 == false)
        XCTAssert(isValid.1 == "Please enter valid First name, Last name, Email address, Password.");
        isValid = signupViewModel.isInputValid(signupInput: SignupInputModel(firstName: nil,
                                                                             lastName: nil,
                                                                             emailID: "dummy@gmail.com",
                                                                             password: "Pass1234!"))
        XCTAssert(isValid.0 == false)
        XCTAssert(isValid.1 == "Please enter valid First name, Last name.");
        
        //Valid input test
        isValid = signupViewModel.isInputValid(signupInput: SignupInputModel(firstName: "Smitha",
                                                                             lastName: "Reddy",
                                                                             emailID: "dummy@gmail.com",
                                                                             password: "Pass1234!"))
        XCTAssert(isValid.0 == true)
        XCTAssert(isValid.1 == nil);
        
    }
}
