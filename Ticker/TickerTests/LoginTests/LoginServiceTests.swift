//
//  LoginServiceTests.swift
//  TickerTests
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import XCTest
@testable import Ticker

class LoginServiceTests: XCTestCase {
    var loginService: LoginService!
    
    override func setUp() {
        loginService = LoginService()
        loginService.managedObjectContext = MockCoreDataUtility.managedObjectContext()
    }

    override func tearDown() {
    }

    func testIfAccountAlreadyExists() {
        var exists = loginService.doesAccountAlreadyExist(email: "dummy@gmail.com")
        XCTAssertFalse(exists)
        
        //Add account
        loginService.addAccount(signupInput: SignupInputModel(firstName: "Smitha", lastName: "Reddy", emailID: "dummy@gmail.com", password: "Pass1234!")) {
            (isSuccess) in
            XCTAssertTrue(isSuccess)
        }
        
        exists = loginService.doesAccountAlreadyExist(email: "dummy@gmail.com")
        XCTAssertTrue(exists)
    }
    
    func testGetUserList() {
        loginService.addAccount(signupInput: SignupInputModel(firstName: "Smitha", lastName: "Reddy", emailID: "dummy@gmail.com", password: "Pass1234!")) {
            (isSuccess) in
            XCTAssertTrue(isSuccess)
        }
        //Valid email
        var userList = loginService.getUserList(email: "dummy@gmail.com")
        XCTAssertNotNil(userList)
        XCTAssert(userList!.count == 1)
        
        //Invalid email
        userList = loginService.getUserList(email: "reddy@gmail.com")
        XCTAssert(userList!.count == 0)
    }
    
    func testIsValidUserInput() {
        //Valid input
        var isValid = loginService.isValidUserInput(SignupInputModel(firstName: "Smitha",
                                                       lastName: "Reddy",
                                                       emailID: "dummy@gmail.com",
                                                       password: "Pass1234!"))
        XCTAssertTrue(isValid)
        
        //Invalid input
        isValid = loginService.isValidUserInput(SignupInputModel(firstName: "Smitha",
                                                                     lastName: "Reddy",
                                                                     emailID: nil,
                                                                     password: nil))
        XCTAssertFalse(isValid)
        isValid = loginService.isValidUserInput(SignupInputModel(firstName: nil,
                                                                 lastName: "",
                                                                 emailID: "dummy@gmail.com",
                                                                 password: "Pass1234!"))
        XCTAssertFalse(isValid)
    }
    
    func testAddAccount() {
        loginService.addAccount(signupInput: SignupInputModel(firstName: "Smitha",
                                                              lastName: "Reddy",
                                                              emailID: "dummy@gmail.com",
                                                              password: "Pass1234!")) { (isSuccess) in
                                                                XCTAssertTrue(isSuccess)
        }
    }
}
