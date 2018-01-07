import UIKit

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(named: "ghost")
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Costume Party!"
            titleLabel.font = UIFont.h1
            titleLabel.textColor = UIColor.primaryTextColor
        }
    }
    @IBOutlet weak var credentialsContainer: UIView!
    @IBOutlet weak var credentialsStackView: UIStackView!
    @IBOutlet weak var usernameTextField: CredentialsTextField! {
        didSet {
            usernameTextField.placeholder = "Email..."
        }
    }
    @IBOutlet weak var passwordTextField: CredentialsTextField! {
        didSet {
            passwordTextField.placeholder = "Password..."
            passwordTextField.isSecureTextEntry = true
        }
    }
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
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            authorLabel.text = "By Lane Faison"
            authorLabel.font = UIFont.h5
            authorLabel.textColor = UIColor.lighterGrey
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        setupCredentialsContainer()
    }
    
    fileprivate func setupCredentialsContainer() {
        credentialsContainer.layer.borderColor = UIColor.darkerGrey.cgColor
        credentialsContainer.layer.borderWidth = 2.0
        credentialsContainer.layer.cornerRadius = 10.0
        credentialsContainer.clipsToBounds = true
    }
    
    @IBAction func registerButtonTapped(_ sender: SecondaryButton) {

    }
}
