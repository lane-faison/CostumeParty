import UIKit

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: CredentialsTextField!
    @IBOutlet weak var passwordTextField: CredentialsTextField!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var registerButton: SecondaryButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        setupView()
        view.setGradientBackground(color1: UIColor.darkPrimary, color2: UIColor.accentColor)
    }
    
    func setupView() {
        imageView.image = UIImage(named: "ghost")
        titleLabel.text = "Costume Party!"
        titleLabel.font = UIFont.h1
        titleLabel.textColor = UIColor.white.darkerColor()
        usernameTextField.placeholder = "Email..."
        passwordTextField.placeholder = "Password..."
        passwordTextField.isSecureTextEntry = true
        loginButton.setTitle("Login", for: .normal)
        registerButton.setTitle("Register", for: .normal)
        authorLabel.text = "By Lane Faison"
        authorLabel.font = UIFont.h5
        authorLabel.textColor = UIColor.lighterGrey
    }
}
