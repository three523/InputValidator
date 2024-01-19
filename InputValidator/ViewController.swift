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
    
    private let testEmailTextField = {
        let field = ValidateTextField(fieldName: "email", rules: [.required, .email])
        field.font = .systemFont(ofSize: 16, weight: .regular)
        field.borderStyle = .roundedRect
        return field
    }()
    private let formManager = FormManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testEmailTextField)

        testEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        testEmailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 300).isActive = true
        testEmailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        testEmailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true

        testEmailTextField.onChangeHandler = { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("TestValidate")
        }
        testEmailTextField.textChangeAction(enable: true)
        
        let passwordFieldModel = FieldModel(fieldName: "password", isRequired: true, type: .password)
        let confirmFieldModel = FieldModel(fieldName: "passwordConfirm", fieldNameToCompare: "password")
        formManager.appendForm(fieldModel: passwordFieldModel) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("Password Validate")
        }
        
        formManager.appendForm(fieldModel: confirmFieldModel) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
            print("Confirm Validate")
        }
        
        passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        passwordConfirmTextField.addTarget(self, action: #selector(confirmDidChange), for: .editingChanged)
    }

    @objc func emailDidChange(_ textField: UITextField) {
        formManager.validate(fieldName: "email", data: ["email": textField.text])
    }
    
    @objc func confirmDidChange(_ textField: UITextField) {
        formManager.validate(fieldName: "passwordConfirm", data: ["passwordConfirm": textField.text, "password": passwordTextField.text])
    }
    
    @objc func passwordDidChange(_ textField: UITextField) {
        formManager.validate(fieldName: "password", data: ["password": textField.text])
        formManager.validate(fieldName: "passwordConfirm", data: ["passwordConfirm": passwordConfirmTextField.text, "password": passwordTextField.text])
    }
    @IBAction func okButtonClick(_ sender: Any) {
        print(formManager.formValidateResult())
    }
}
