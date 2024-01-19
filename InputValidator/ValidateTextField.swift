//
//  UITextField+Validate.swift
//  InputValidator
//
//  Created by 김도현 on 2024/01/17.
//

import UIKit

enum Rule {
    case email
    case required
    case custom(CustomValidationTest)
}

final class ValidateTextField: UITextField, UITextFieldDelegate {
    var fieldName: String
    var onFocusOutHandler: ((ValidateError?) -> Void)?
    var onChangeHandler: ((ValidateError?) -> Void)?
    var rules: [ValidatableTest]
    private var formValidator: FormValidatorTest = FormValidatorTest(validations: [])
    
    init(fieldName: String, onFocusOutHandler: ((ValidateError?) -> Void)? = nil, onChangeHandler: ((ValidateError?) -> Void)? = nil, rules: [Rule] = []) {
        self.fieldName = fieldName
        self.onFocusOutHandler = onFocusOutHandler
        self.onChangeHandler = onChangeHandler
        self.rules = []
        
        for rule in rules {
            switch rule {
            case .email:
                self.rules.append(EmailValidationTest(fieldName: fieldName, emailValidator: EmailValidator()))
            case .required:
                self.rules.append(RequiredFieldValidationTest(fieldName: fieldName))
            case .custom(let validatable):
                self.rules.append(validatable)
            }
        }
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRules(rules: [Rule]) {
        for rule in rules {
            switch rule {
            case .email:
                self.rules.append(EmailValidationTest(fieldName: fieldName, emailValidator: EmailValidator()))
            case .required:
                self.rules.append(RequiredFieldValidationTest(fieldName: fieldName))
            case .custom(let validatable):
                self.rules.append(validatable)
            }
        }
    }
    
    func textChangeAction(enable: Bool) {
        switch enable {
        case true:
            addTarget(self, action: #selector(textChange), for: .editingChanged)
        case false:
            removeTarget(self, action: #selector(textChange), for: .editingChanged)
        }
    }
    
    @objc private func textChange() {
        onChangeHandler?(text?.validate(rules: rules))
    }
}
