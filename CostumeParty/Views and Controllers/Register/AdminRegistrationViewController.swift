import UIKit

class AdminRegistrationViewController: UIViewController {
    
    @IBOutlet weak var partyNameLabel: UILabel!
    @IBOutlet weak var partyZipcodeLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var yourCostumeLabel: UILabel!
    
    @IBOutlet weak var partyNameTextField: PrimaryTextField!
    @IBOutlet weak var partyZipcodeTextField: PrimaryTextField!
    @IBOutlet weak var yourNameTextField: PrimaryTextField!
    @IBOutlet weak var yourCostumeTextField: PrimaryTextField!

    @IBOutlet weak var submitButton: PrimaryButton! {
        didSet {
            submitButton.setTitle("Submit", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func submitButtonTapped(_ sender: PrimaryButton) {
        let readyToRegister: Bool = checkFields()
        
        if readyToRegister {
            print("Submit register here")
        } else {
            print("Not yet ready to submit register")
        }
    }
}

extension AdminRegistrationViewController {
    func checkFields() -> Bool {
        print("Tapped")
        if partyNameTextField.text?.isEmpty ?? false {
            print("Party name empty")
            partyNameLabel.textColor = UIColor.red
        }
        if partyZipcodeTextField.text?.isEmpty ?? false {
            print("Party zipcode empty")
            partyZipcodeLabel.textColor = UIColor.red
        }
        if yourNameTextField.text?.isEmpty ?? false {
            print("Your name is empty")
            yourNameLabel.textColor = UIColor.red
        }
        if yourCostumeTextField.text?.isEmpty ?? false {
            print("Your costume is empty")
            yourCostumeLabel.textColor = UIColor.red
        }
        
        return true
    }
}
