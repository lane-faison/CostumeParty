import UIKit

class RegistrationViewController: UIViewController {
    
    var guestMode: Bool = false
    
    let standardErrorMessage: String = "Please complete all RED fields"
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var partyZipcodeLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var yourCostumeLabel: UILabel!
    
    @IBOutlet weak var partyNameTextField: PrimaryTextField!
    @IBOutlet weak var partyZipcodeTextField: PrimaryTextField!
    @IBOutlet weak var yourNameTextField: PrimaryTextField!
    @IBOutlet weak var yourCostumeTextField: PrimaryTextField!

    @IBOutlet weak var submitButton: PrimaryButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        if guestMode {
            hideAdminFields()
        }
        
        setupView()
    }
    
    // Submit Button action
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
    
    func setupView() {
        partyNameLabel.textColor = UIColor.primaryTextColor
        partyZipcodeLabel.textColor = UIColor.primaryTextColor
        yourNameLabel.textColor = UIColor.primaryTextColor
        yourCostumeLabel.textColor = UIColor.primaryTextColor
        partyZipcodeTextField.keyboardType = UIKeyboardType.numberPad
        
        submitButton.setTitle("Submit", for: .normal)
        
        errorLabel.isHidden = true
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.h3
        errorLabel.text = standardErrorMessage
    }
    
    func checkFields() -> Bool {
        
        // These fields only concern Admin registration
        if !guestMode {
            partyNameLabel.textColor = partyNameTextField.text?.isEmpty ?? false ? UIColor.red : UIColor.primaryTextColor
            partyZipcodeLabel.textColor = partyZipcodeTextField.text?.isEmpty ?? false || partyZipcodeTextField.text?.count != 5 ? UIColor.red : UIColor.primaryTextColor
            errorLabel.text = partyZipcodeTextField.text?.count != 5 ? "Please enter a 5-digit zip code" : standardErrorMessage
        }
        
        // These fields concern both Guest and Admin registration
        yourNameLabel.textColor = yourNameTextField.text?.isEmpty ?? false ? UIColor.red : UIColor.primaryTextColor
        yourCostumeLabel.textColor = yourCostumeTextField.text?.isEmpty ?? false ? UIColor.red : UIColor.primaryTextColor
        
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
