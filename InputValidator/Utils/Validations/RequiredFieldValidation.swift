//
//  RequeridInput.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/07.
//

import Foundation

final class RequiredFieldValidation: Validatable {
    let fieldName: String
    
    init(fieldName: String) {
        self.fieldName = fieldName
    }
    
    func validate(data: [String: Any]?) -> ValidateError? {
        guard let fieldText = data?[fieldName] as? String,
              fieldText.isEmpty == false else { return .requiredEmpty(fieldName) }
        return nil
    }
}

final class RequiredFieldValidationTest: ValidatableTest {
    let fieldName: String
    
    init(fieldName: String) {
        self.fieldName = fieldName
    }
    
    func validate(fieldText: String?) -> ValidateError? {
        guard let fieldText,
              fieldText.isEmpty == false else { return .requiredEmpty(fieldName) }
        return nil
    }
}
