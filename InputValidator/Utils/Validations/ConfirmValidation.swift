//
//  PasswordConfirmValidator.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/08.
//

import Foundation

final class ConfirmValidation: Validatable {
    private let fieldName: String
    private let fieldNameToCompare: String
    
    init(fieldName: String, fieldNameToCompare: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    func validate(data: [String : Any]?) -> ValidateError? {
        guard let fieldText = data?[fieldName] as? String,
              let fieldToCompareText = data?[fieldNameToCompare] as? String,
              fieldText == fieldToCompareText else { return .confirm(fieldName, fieldNameToCompare) }
        return nil
    }
}

final class ConfirmValidationTest: ValidatableTest {
    private let fieldName: String
    private let fieldNameToCompare: String
    var confirmTextHandler: (() -> String?)?
    
    init(fieldName: String, fieldNameToCompare: String, confirmTextHandler: @escaping (() -> String?)) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.confirmTextHandler = confirmTextHandler
    }
    
    func validate(fieldText: String?) -> ValidateError? {
        guard let fieldText = fieldText,
              let fieldToCompareText = confirmTextHandler?(),
              fieldText == fieldToCompareText else { return .confirm(fieldName, fieldNameToCompare) }
        return nil
    }
}
