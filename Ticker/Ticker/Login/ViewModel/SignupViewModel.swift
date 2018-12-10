//
//  SignupViewModel.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit

class SignupViewModel: NSObject {
    
    func signup(signupInput: SignupInputModel, completionHandler: @escaping ((Bool, String?) -> Void)) {
        let isDataValid = isInputValid(signupInput: signupInput)
        if isDataValid.0 == false {
            completionHandler(isDataValid.0, isDataValid.1)
        } else {
            LoginService().signup(signupInput: signupInput) { (isSuccess, errorMessage)  in
                completionHandler(isSuccess, errorMessage)
            }
        }
    }
    
    func isInputValid(signupInput: SignupInputModel) -> (Bool, String?) {
        var invalidInputs: [String] = [String]()
        if !ValidationUtility.isValidName(signupInput.firstName) {
            invalidInputs.append(NSLocalizedString("Firstname", comment: "Firstname field"))
        }
        if !ValidationUtility.isValidName(signupInput.lastName) {
            invalidInputs.append(NSLocalizedString("Lastname", comment: "Lastname field"))
        }
        if !ValidationUtility.isValidEmail(signupInput.emailID) {
            invalidInputs.append(NSLocalizedString("EmailId", comment: "Email field"))
        }
        if !ValidationUtility.isValidPassword(signupInput.password) {
            invalidInputs.append(NSLocalizedString("Password", comment: "Password field"))
        }
        if invalidInputs.count > 0 {
            let errorMessage = getSignupValidationError(invalidInputs: invalidInputs)
            return (false, errorMessage)
        }
        return (true, nil)
    }
    
    func getSignupValidationError(invalidInputs: [String]) -> String {
        var errorMessage = NSLocalizedString("ValidationError_Message", comment: "Signup input invalid error")
        let errorFieldsString = invalidInputs.joined(separator: ", ")
        errorMessage = errorMessage.replacingOccurrences(of: "{inputValues}", with: errorFieldsString)
        return errorMessage
    }
}
