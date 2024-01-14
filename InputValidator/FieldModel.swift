//
//  FieldModel.swift
//  FormManager
//
//  Created by 김도현 on 2024/01/13.
//

import Foundation

struct FieldModel: Model {
    
    enum ValidateType: String, Codable {
        case email
        case password
        case confirm
        case custom
    }
    
    let fieldName: String
    let fieldNameToCompare: String?
    let isRequired: Bool
    let type: ValidateType
    let pattern: String?
    
    init(fieldName: String, isRequired: Bool, type: ValidateType) {
        self.fieldName = fieldName
        self.fieldNameToCompare = nil
        self.isRequired = isRequired
        self.type = type
        self.pattern = nil
    }
    
    init(fieldName: String, fieldNameToCompare: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.isRequired = true
        self.type = .confirm
        self.pattern = nil
    }
    
    init(fieldName: String, isRequired: Bool, pattern: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = nil
        self.isRequired = isRequired
        self.type = .custom
        self.pattern = pattern
    }
    
}
