//
//  PhoneNumberValidator.swift
//  InputManager
//
//  Created by 김도현 on 2024/01/12.
//

import Foundation

final class PhoneNumberValidator: Validator {
    let pattern: String = "^01[0-9]{8,9}$"
}
