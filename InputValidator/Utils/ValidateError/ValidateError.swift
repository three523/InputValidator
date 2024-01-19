//
//  ValidateError.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/07.
//

import Foundation

typealias FieldName = String
typealias ConfirmFieldName = String

enum ValidateError: Error, Equatable {
    case requiredEmpty(FieldName)
    case validate(FieldName)
    case confirm(FieldName, ConfirmFieldName)
}

extension ValidateError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .validate(let fieldName):
            return NSLocalizedString("\(fieldName) is not Validate", comment: "")
        case .confirm(let fieldName, let confirmFieldName):
            return NSLocalizedString("\(fieldName) and \(confirmFieldName) are not the same", comment: "")
        case .requiredEmpty(let fieldName):
            return NSLocalizedString("\(fieldName) is required", comment: "")
        }
    }
}
