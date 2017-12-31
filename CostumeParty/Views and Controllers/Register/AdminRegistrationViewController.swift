import UIKit

class AdminRegistrationViewController: UIViewController {
    
    @IBOutlet weak var submitButton: PrimaryButton! {
        didSet {
            submitButton.setTitle("Submit", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        
    }
}
