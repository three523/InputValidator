//
//  FormManager.swift
//  FormManager
//
//  Created by 김도현 on 2024/01/13.
//

import UIKit

final class FormManager {
    
    typealias onChange = (ValidateError?) -> Void
    
    private var forms: [FieldName: FormValidator] = [:]
    private var onChanges: [FieldName: onChange?] = [:]
    private var result: [FieldName: Bool] = [:]
    
    func appendForm(fieldModel: FieldModel, onChange: onChange?) {
        let fieldName = fieldModel.fieldName
        let isRequired = fieldModel.isRequired
        
        let builder = ValidateBuilder.field(fieldName: fieldName)
        
        if isRequired { builder.required() }
        
        switch fieldModel.type {
        case .email:
            builder.email()
        case .password:
            builder.passowrd()
        case .confirm:
            guard let fieldNameToCompare = fieldModel.fieldNameToCompare else {
                fatalError("Confirm fieldName is not exist")
            }
            builder.confirm(confirmFieldName: fieldNameToCompare)
        case .custom:
            guard let pattern = fieldModel.pattern else {
                fatalError("Pattern is not exist")
            }
            builder.custom(pattern: pattern)
            break
        }
        
        forms[fieldName] = builder.build()
        onChanges[fieldName] = onChange
        
        // TODO: 유효성 검사를 모든 경우에 할지, 모두 안 할지, 필수 입력인 경우만 할지를 선택할 수 있도록 구현하기
        if isRequired { validate(fieldName: fieldName, data: [fieldName: ""]) }
    }
    
    func validate(fieldName: String, data: [String: Any]) {
        let error = forms[fieldName]?.validate(data: data)
        result[fieldName] = error == nil
        guard let onChange = onChanges[fieldName] else { return }
        onChange?(error)
    }
    
    func formValidateResult() -> Bool {
        return !result.values.contains(false)
    }
}
