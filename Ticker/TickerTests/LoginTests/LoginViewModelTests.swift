//
//  LoginViewModelTests.swift
//  TickerTests
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import XCTest
@testable import Ticker

class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        loginViewModel = LoginViewModel()
    }

    override func tearDown() {
    }
    
    func testIsInputValid() {
        //Invalid input test
        var isValid = loginViewModel.isInputValid(email: nil,
                                                  password: nil)
        XCTAssert(isValid.0 == false)
        XCTAssert(isValid.1 == "Please enter valid Email address, Password.");
        
        isValid = loginViewModel.isInputValid(email: "dummy@gmail.com",
                                              password: "")
        XCTAssert(isValid.0 == false)
        XCTAssert(isValid.1 == "Please enter valid Password.");
        
        //Valid input test
        isValid = loginViewModel.isInputValid(email: "dummy@gmail.com",
                                              password: "Pass1234!")
        XCTAssert(isValid.0 == true)
        XCTAssert(isValid.1 == nil);
        
    }
    
    func testLoginValidationError() {
        let invalidInputs = ["Email address", "Password"]
        let errorMessage = loginViewModel.getLoginValidationError(invalidInputs: invalidInputs)
        XCTAssert(errorMessage == "Please enter valid Email address, Password.")
    }
}
