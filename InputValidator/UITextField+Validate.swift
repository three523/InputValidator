//
//  UITextField+Validate.swift
//  InputValidator
//
//  Created by 김도현 on 2024/01/17.
//

import UIKit

extension UITextField {
    
    private static var customPropertyKey: UInt8 = 0
    private static var onFocusKey: UInt8 = 0
    private static var onChangeKey: UInt8 = 0

    var customName: String? {
        get {
            return objc_getAssociatedObject(self, &Self.customPropertyKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &Self.customPropertyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var onFocusOutHandler: ((ValidateError?) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &Self.onFocusKey) as? ((ValidateError?) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &Self.onFocusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var onChangeHandler: ((ValidateError?) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &Self.onChangeKey) as? ((ValidateError?) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &Self.onChangeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func foucsOutAction(enable: Bool) {
        switch enable {
        case true:
            addTarget(self, action: #selector(focusOut), for: .editingDidEnd)
        case false:
            removeTarget(self, action: #selector(focusOut), for: .editingDidEnd)
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
    
    @objc func focusOut(_ textField: UITextField) {
        onFocusOutHandler?(.validate(customName ?? self.description))
    }
    
    @objc func textChange(_ textField: UITextField) {
        onChangeHandler?(.validate(customName ?? self.description))
    }
}
