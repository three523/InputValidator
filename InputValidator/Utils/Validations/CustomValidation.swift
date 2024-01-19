//
//  CustomValidation.swift
//  FormManager
//
//  Created by 김도현 on 2024/01/13.
//

import Foundation

final class CustomValidation: Validatable {
    private let fieldName: String
    private let customValidator: Validator
    
    init(fieldName: String, pattern: String) {
        self.fieldName = fieldName
        self.customValidator = CustomValidator(pattern: pattern)
    }
    
    func validate(data: [String : Any]?) -> ValidateError? {
        guard let value = data?[fieldName] as? String,
              customValidator.isValid(text: value) else { return .validate(fieldName) }
        return nil
    }
}

final class CustomValidationTest: ValidatableTest {
    private let fieldName: String
    private let customValidator: Validator
    
    init(fieldName: String, pattern: String) {
        self.fieldName = fieldName
        self.customValidator = CustomValidator(pattern: pattern)
    }
    
    func validate(fieldText: String?) -> ValidateError? {
        guard let value = fieldText,
              customValidator.isValid(text: value) else { return .validate(fieldName) }
        return nil
    }
}
