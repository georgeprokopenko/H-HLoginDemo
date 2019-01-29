//
//  FieldValidationHelper.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class FieldValidationHelper: NSObject {
    var defaultPassValidationConditions = PassValidationConditions();
    
    struct PassValidationConditions {
        var minimumChars : Int = 6
        var includingLowerChar: Bool = true
        var includingUpperChar: Bool = true
        var includingNumber: Bool = true
    }
    
    func isPasswordValid(password: String) -> Bool {
        if password.count >= defaultPassValidationConditions.minimumChars {
            
            if defaultPassValidationConditions.includingLowerChar {
                let capitalLettersRegEx  = ".*[A-Z]+.*"
                let predicate = NSPredicate(format:"SELF MATCHES %@", capitalLettersRegEx)
                let containsCapitals = predicate.evaluate(with: password)
                
                if containsCapitals, defaultPassValidationConditions.includingUpperChar {
                    let lowerLettersRegEx  = ".*[a-z]+.*"
                    let predicate = NSPredicate(format:"SELF MATCHES %@", lowerLettersRegEx)
                    let containsLowers = predicate.evaluate(with: password)
                    
                    if containsLowers, defaultPassValidationConditions.includingNumber {
                        let numberRegEx  = ".*[0-9]+.*"
                        let predicate = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
                        let containsNumber = predicate.evaluate(with: password)
                        
                        return containsNumber
                    } else {
                        return containsLowers
                    }
                }
                else {
                    return containsCapitals
                }
            }
            
            
            return true
        }
        
        return false
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
        
    }
}
