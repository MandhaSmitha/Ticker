//
//  LoginViewModel.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    
    func login(email: String?, password: String?, completionHandler: @escaping ((Bool, String?) -> Void)) {
        let isDataValid = isInputValid(email: email, password: password)
        if isDataValid.0 == false {
            completionHandler(isDataValid.0, isDataValid.1)
        } else {
            LoginService().login(email: email!, password: password!) {
                (isSuccess, errorMessage) in
                completionHandler(isSuccess, errorMessage)
            }
        }
    }
    
    func isInputValid(email: String?, password: String?) -> (Bool, String?) {
        var invalidInputs: [String] = [String]()
        if !ValidationUtility.isValidEmail(email) {
            invalidInputs.append(NSLocalizedString("EmailId", comment: "Email field"))
        }
        if !ValidationUtility.isValidPassword(password) {
            invalidInputs.append(NSLocalizedString("Password", comment: "password field"))
        }
        if invalidInputs.count > 0 {
            let errorMessage = getLoginValidationError(invalidInputs: invalidInputs)
            return (false, errorMessage)
        }
        return (true, nil)
    }
    
    func getLoginValidationError(invalidInputs: [String]) -> String {
        var errorMessage = NSLocalizedString("ValidationError_Message", comment: "Login input invalid error")
        let errorFieldsString = invalidInputs.joined(separator: ", ")
        errorMessage = errorMessage.replacingOccurrences(of: "{inputValues}", with: errorFieldsString)
        return errorMessage
    }
}
