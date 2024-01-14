//
//  ViewController.swift
//  FormManager
//
//  Created by 김도현 on 2024/01/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    private let formManager = FormManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(emailDidChange), for: .editingChanged)
        let fieldModel = FieldModel(fieldName: "email", isRequired: true, type: .email)
        let passwordFieldModel = FieldModel(fieldName: "password", isRequired: true, type: .password)
        let passwordConfirmModel = FieldModel(fieldName: "passwordConfirm", fieldNameToCompare: "phoneNumber")
        formManager.appendForm(fieldModel: fieldModel) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("email Validate")
        }
        
        passwordConfirmTextField.addTarget(self, action: #selector(confirmDidChange), for: .allEditingEvents)
        formManager.appendForm(fieldModel: passwordConfirmModel) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("confirm")
        }
        
        let phoneNumberFieldModel = FieldModel(fieldName: "phoneNumber", isRequired: false, pattern: "^01[0-9]{8,9}$")
        
        passwordTextField.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        formManager.appendForm(fieldModel: phoneNumberFieldModel) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("phone Validate")
        }
        // Do any additional setup after loading the view.
    }

    @objc func emailDidChange(_ textField: UITextField) {
        formManager.validate(fieldName: "email", data: ["email": textField.text])
    }
    
    @objc func confirmDidChange(_ textField: UITextField) {
        formManager.validate(fieldName: "passwordConfirm", data: ["passwordConfirm": textField.text, "phoneNumber": passwordTextField.text])
    }
    
    @objc func phoneNumberDidChange(_ textField: UITextField) {
        formManager.validate(fieldName: "phoneNumber", data: ["phoneNumber": textField.text])
    }
    @IBAction func okButtonClick(_ sender: Any) {
        print(formManager.formValidateResult())
    }
}

