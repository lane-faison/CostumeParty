import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: PrimaryButton! {
        didSet {
            loginButton.setTitle("Login", for: .normal)
        }
    }
    @IBOutlet weak var registerButton: PrimaryButton! {
        didSet {
            registerButton.setTitle("Register", for: .normal)
            registerButton.buttonBorderColor = UIColor.darkGray
            registerButton.backgroundColor = .blue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

