//
//  String.swift
//  InputValidator
//
//  Created by 김도현 on 2024/01/18.
//

import Foundation

extension String {
    func validate(rules: [ValidatableTest]) -> ValidateError? {
        for rule in rules {
            if let error = rule.validate(fieldText: self) {
                return error
            }
        }
        return nil
    }
}
