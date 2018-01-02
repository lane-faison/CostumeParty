import UIKit

class RegistrationViewController: UIViewController {
    
    var guestMode: Bool = false
    
    let standardErrorMessage: String = "Please complete all RED fields"
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var partyZipcodeLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var yourCostumeLabel: UILabel!
    
    @IBOutlet weak var partyNameTextField: PrimaryTextField!
    @IBOutlet weak var partyZipcodeTextField: PrimaryTextField! {
        didSet {
            partyZipcodeTextField.keyboardType = UIKeyboardType.numberPad
        }
    }
    @IBOutlet weak var yourNameTextField: PrimaryTextField!
    @IBOutlet weak var yourCostumeTextField: PrimaryTextField!

    @IBOutlet weak var submitButton: PrimaryButton! {
        didSet {
            submitButton.setTitle("Submit", for: .normal)
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.isHidden = true
            errorLabel.textColor = UIColor.red
            errorLabel.font = UIFont.h3
            errorLabel.text = standardErrorMessage
        }
    }
    
    override func viewDidLoad() {
        if guestMode {
            hideAdminFields()
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: PrimaryButton) {
        
        view.endEditing(true)
        let readyToRegister: Bool = checkFields()
        
        if readyToRegister {
            // Make call to register new admin
            errorLabel.text = "Success!"
            errorLabel.textColor = UIColor.green
            errorLabel.isHidden = false
        } else {
            print("Not yet ready to submit register")
        }
    }
}

extension RegistrationViewController {
    
    func hideAdminFields() {
        partyNameLabel.isHidden = true
        partyNameTextField.isHidden = true
        partyZipcodeLabel.isHidden = true
        partyZipcodeTextField.isHidden = true
    }
    
    func checkFields() -> Bool {
        
        // These fields only concern Admin registration
        if !guestMode {
            if partyNameTextField.text?.isEmpty ?? false {
                partyNameLabel.textColor = UIColor.red
            }
            if partyZipcodeTextField.text?.isEmpty ?? false || partyZipcodeTextField.text?.count != 5 {
                partyZipcodeLabel.textColor = UIColor.red
            }
            
            if partyZipcodeTextField.text?.count != 5 {
                errorLabel.text = "Please enter a 5-digit zip code"
            } else {
                errorLabel.text = standardErrorMessage
            }
        }
        
        // These fields concern both Guest and Admin registration
        if yourNameTextField.text?.isEmpty ?? false {
            yourNameLabel.textColor = UIColor.red
        }
        if yourCostumeTextField.text?.isEmpty ?? false {
            yourCostumeLabel.textColor = UIColor.red
        }
        
        // Checks for Admin mode or Guest mode
        if !guestMode {
            if partyNameTextField.text?.isEmpty ?? false ||
                partyZipcodeTextField.text?.isEmpty ?? false ||
                partyZipcodeTextField.text?.count != 5 ||
                yourNameTextField.text?.isEmpty ?? false ||
                yourCostumeTextField.text?.isEmpty ?? false {
                errorLabel.isHidden = false
                return false
            }
        } else {
            if yourNameTextField.text?.isEmpty ?? false ||
                yourCostumeTextField.text?.isEmpty ?? false {
                errorLabel.isHidden = false
                return false
            }
        }
        
        errorLabel.isHidden = true
        return true
    }
}
