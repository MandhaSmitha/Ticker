//
//  LoginService.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit
import CoreData

enum UserKeys: String {
    case firstName
    case lastName
    case emailID
    case password
}

class LoginService: NSObject {
    
    func signup(signupInput: SignupInputModel, completionHandler: @escaping ((Bool, String?) -> Void)) {
        if isValidUserInput(signupInput) {
            let accountExists = doesAccountAlreadyExist(email: signupInput.emailID!)
            if accountExists {
                completionHandler(false, LoginErrorMapper.accountAlreadyExists.rawValue)
            } else {
                addAccount(signupInput: signupInput) { (isSuccess) in
                    if isSuccess {
                        completionHandler(isSuccess, nil)
                    } else {
                        completionHandler(isSuccess, LoginErrorMapper.failedToAddAccount.rawValue)
                    }
                }
            }
        } else {
            completionHandler(false, LoginErrorMapper.invalidInput.rawValue)
        }
    }
    
    func login(email: String, password: String, completionHandler: @escaping ((Bool, String?) -> Void)) {
        let userList = getUserList(email: email)
        if let user = userList?.first {
            user.password == password ? completionHandler(true, nil) : completionHandler(false, LoginErrorMapper.invalidCredentials.rawValue)
        } else {
            completionHandler(false, LoginErrorMapper.accountNotFound.rawValue)
        }
    }
    
    func doesAccountAlreadyExist(email: String) -> Bool {
        let userList = getUserList(email: email)
        if let users = userList, users.count > 0 {
            return true
        }
        return false
    }
    
    func getUserList(email: String) -> [Users]? {
        let managedObjectContext = CoreDataUtility.shared.managedObjectContext
        let fetchRequest : NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "emailID=%@", email)
        do {
            let userList = try managedObjectContext.fetch(fetchRequest)
            return userList
        } catch {
            print("Unable to fetch users")
            return nil
        }
    }
    
    func isValidUserInput(_ signupInput: SignupInputModel) -> Bool {
        guard ValidationUtility.isValidName(signupInput.firstName),
            ValidationUtility.isValidName(signupInput.lastName),
            ValidationUtility.isValidEmail(signupInput.emailID),
            ValidationUtility.isValidPassword(signupInput.password) else {
                return false
        }
        return true
    }
    
    func addAccount(signupInput: SignupInputModel, completionHandler: @escaping ((Bool) -> Void)) {
        let managedObjectContext = CoreDataUtility.shared.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedObjectContext)!
        let recentSearch = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        recentSearch.setValue(signupInput.firstName!, forKey: UserKeys.firstName.rawValue)
        recentSearch.setValue(signupInput.lastName!, forKey: UserKeys.lastName.rawValue)
        recentSearch.setValue(signupInput.emailID!, forKey: UserKeys.emailID.rawValue)
        recentSearch.setValue(signupInput.password!, forKey: UserKeys.password.rawValue)
        CoreDataUtility.shared.saveContext { (isSuccess) in
            completionHandler(isSuccess)
        }
    }
}
