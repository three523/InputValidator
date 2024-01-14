//
//  PasswordValidation.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/08.
//

import Foundation

final class PasswordValidation: Validatable {
    private let fieldName: String
    private let passwordValidator: Validator
    
    init(fieldName: String, passwordValidator: Validator) {
        self.fieldName = fieldName
        self.passwordValidator = passwordValidator
    }
    
    func validate(data: [String : Any]?) -> ValidateError? {
        guard let password = data?[fieldName] as? String,
              passwordValidator.isValid(text: password) else { return .validate(fieldName) }
        return nil
    }
}
