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
}
