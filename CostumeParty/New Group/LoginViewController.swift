import UIKit
import Firebase

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: CredentialsTextField!
    @IBOutlet weak var passwordTextField: CredentialsTextField!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var registerButton: PrimaryButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
        view.applySecondaryBackgroundGradient()
    }
    
    private func setupView() {
        imageView.image = UIImage(named: "ghost")
        
        titleLabel.text = "Costume Party!"
        titleLabel.font = UIFont.h2
        titleLabel.textColor = .primaryTextColor
        
        usernameTextField.setPlaceholderText("Email...")
        passwordTextField.setPlaceholderText("Password...")
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.addTarget(self, action: #selector(userTappedLogin), for: .touchUpInside)
        loginButton.primaryColor = .primaryTextColor
        loginButton.setTitleColor(.secondaryDarkColor, for: .normal)
        
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.addTarget(self, action: #selector(userTappedRegister), for: .touchUpInside)
        registerButton.primaryColor = .primaryTextColor
        registerButton.setTitleColor(.secondaryDarkColor, for: .normal)
        
        authorLabel.text = "By Lane Faison"
        authorLabel.font = UIFont.h5
        authorLabel.textColor = .primaryTextColor
    }
    
    @objc func userTappedLogin() {
        guard let email = usernameTextField.text,
            let password = passwordTextField.text else {
                let message = "Please complete all fields before trying to log in!"
                AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                return
        }
        
        userLogin(email: email, password: password) { (success) in
            if success {
                guard let lobbyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LobbyViewController") as? LobbyViewController else { return }
                self.navigationController?.pushViewController(lobbyVC, animated: true)
            }
        }
    }
    
    @objc func userTappedRegister() {
        performSegue(withIdentifier: "toRegistration", sender: self)
    }
}

extension LoginViewController {
    private func userLogin(email: String, password: String, completion: @escaping (Bool) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let error = error {
                    AlertHelper.fireErrorActionSheet(viewController: self, message: error.localizedDescription)
                    return
                }
            } else {
                completion(true)
            }
        }
    }
}
