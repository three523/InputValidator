//
//  ValidationHandler.swift
//  FormManager
//
//  Created by 김도현 on 2024/01/13.
//

import Foundation

final class FormValidator: Validatable {
    private let validations: [Validatable]
    
    init(validations: [Validatable]) {
        self.validations = validations
    }
    
    func validate(data: [String : Any]?) -> ValidateError? {
        for validation in validations {
            if let error = validation.validate(data: data) {
                return error
            }
        }
        return nil
    }
}
