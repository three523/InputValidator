//
//  ValidateBuilder.swift
//  FormManager
//
//  Created by 김도현 on 2024/01/13.
//

import Foundation

final class ValidateBuilder {
    private var validations: [Validatable] = []
    private let fieldName: String
    
    init (fieldName: String) {
        self.fieldName = fieldName
    }
    
    static func field(fieldName: String) -> ValidateBuilder {
        return ValidateBuilder(fieldName: fieldName)
    }
    
    func required() {
        validations.append(RequiredFieldValidation(fieldName: fieldName))
    }
    
    func email() {
        validations.append(EmailValidation(fieldName: fieldName, emailValidator: EmailValidator()))
    }
    
    func passowrd() {
        validations.append(PasswordValidation(fieldName: fieldName, passwordValidator: PasswordValidator()))
    }
    
    func confirm(confirmFieldName: String) {
        validations.append(ConfirmValidation(fieldName: fieldName, fieldNameToCompare: confirmFieldName))
    }
    
    func custom(pattern: String) {
        validations.append(CustomValidation(fieldName: fieldName, pattern: pattern))
    }
    
    func build() -> FormValidator {
        return FormValidator(validations: validations)
    }
}
