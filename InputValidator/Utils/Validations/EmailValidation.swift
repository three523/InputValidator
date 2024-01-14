//
//  EmailValidation.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/08.
//

import Foundation

final class EmailValidation: Validatable {
    private let fieldName: String
    private let emailValidator: Validator
    
    init(fieldName: String, emailValidator: Validator) {
        self.fieldName = fieldName
        self.emailValidator = emailValidator
    }
    
    func validate(data: [String : Any]?) -> ValidateError? {
        guard let email = data?[fieldName] as? String,
              emailValidator.isValid(text: email) else { return .validate(fieldName) }
        return nil
    }
}
