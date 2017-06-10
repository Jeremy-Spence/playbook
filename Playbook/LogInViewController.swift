//
//  LogInViewController.swift
//  Playbook
//
//  Created by Jeremy Spence on 5/11/17.
//  Copyright © 2017 Jeremy Spence. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var emailCheck: UILabel!
    @IBOutlet weak var passwordCheck: UILabel!
    @IBOutlet weak var confirmPasswordCheck: UILabel!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    //MARK: - Stored Variables
    
    let user = User.sharedInstance
    let api = API.sharedInstance
    let persistenceManager = PersistenceManager()
    let firebaseManager = FirebaseManager()
    
    var isEmailText: Bool = false
    var isPasswordText: Bool = false
    var isConfirmPasswordText: Bool = true
    
    var textFields: [UITextField] = []
    var checks: [UILabel] = []
    
    var isContinueButtonOn: Bool = true {
         // Set continue button state
        didSet {
            if isContinueButtonOn == false {
                continueButton.isEnabled = false
                continueButton.setTitleColor(UIColor.lightGray, for: .normal)
            } else {
                continueButton.isEnabled = true
                continueButton.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }

    
    //MARK: - Enums
    
    enum FieldType {
        case email
        case password
        case confirmPassword
        
        func getErrorMessage() -> String {
            switch self {
            case .email: return "please enter a valid email address"
            case .password: return "password must be at least 7 characters"
            case .confirmPassword: return "passwords must match"
            }
        }
        
        
    }
    
    //MARK: - Setup View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        textFields = [emailField, passwordField, confirmPasswordField]
        checks = [emailCheck, passwordCheck, confirmPasswordCheck]
        
        setUp(fields: textFields)
        
        isContinueButtonOn = false
    }
    
    func setUp(fields: [UITextField]) {
        for field in fields {
            field.bottomBorder()
            field.delegate = self
        }
        
        warningLabel.isHidden = true
    }
    
    //MARK: - Save User
    
    @IBAction func signUpButton(_ sender: Any) {
        setupUser()
        presentMainStoryboard()
    }
    
    func setupUser() {
        user.didSeeOnboarding = true
        user.email = emailField.text!
        user.password = passwordField.text!
        
        persistenceManager.saveUser()
        persistenceManager.saveEmail(email: user.email)
    }
    
    func presentMainStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController: UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        self.present(navigationController, animated: false, completion: nil)
    }
    
}

// MARK: - Text Field Delegate Methods

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setUp(field: FieldType, isError: Bool) {
        warningLabel.isHidden = !isError
        warningLabel.text = field.getErrorMessage()
        
        switch field {
        case .email:
            isEmailText = !isError
            emailCheck.isHidden = isError
            
        case .password:
            isPasswordText = !isError
            passwordCheck.isHidden = isError
            
        case .confirmPassword:
            isConfirmPasswordText = !isError
            confirmPasswordCheck.isHidden = isError
        }
    }
    
    func setEmpty(field: FieldType) {
        warningLabel.isHidden = true
        
        switch field {
        
        case .email:
            isEmailText = false
            emailCheck.isHidden = true
            
        case .password:
            isPasswordText = false
            passwordCheck.isHidden = true
            
        case .confirmPassword:
            isConfirmPasswordText = false
            confirmPasswordCheck.isHidden = true
        }
    }
    
    func isTextValid(text: NSString, type: FieldType) -> Bool {
        switch type {
        case .email: return text.contains("@")
        case .password: return text.length > 6
        case .confirmPassword: return text as String == passwordField.text!
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        for field in self.textFields {
            if textField == field {
                
                var fieldType: FieldType?
                
                if field == passwordField {
                    fieldType = .password
                } else if field == confirmPasswordField {
                    fieldType = .confirmPassword
                } else {
                    fieldType = .email
                }
                
                let oldText = field.text! as NSString
                let newText = oldText.replacingCharacters(in: range, with: string) as NSString
                
                if newText.length > 0 {
                    let isValid = isTextValid(text: newText, type: fieldType!)
                    setUp(field: fieldType!, isError: !isValid)
                } else {
                    setEmpty(field: fieldType!)
                }
            }
        }
        
        if isEmailText && isPasswordText && isConfirmPasswordText {
            continueButton.isEnabled = true
            continueButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        
        return true
    }
    
    
}




