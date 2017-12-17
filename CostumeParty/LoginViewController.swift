import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: PrimaryButton! {
        didSet {
            loginButton.setTitle("Login", for: .normal)
        }
    }
    @IBOutlet weak var registerButton: SecondaryButton! {
        didSet {
            registerButton.setTitle("Register", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

