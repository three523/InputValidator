//
//  PasswordValidator.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/08.
//

import Foundation

final class PasswordValidator: Validator {    
    let pattern: String = "^(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,}"
}
