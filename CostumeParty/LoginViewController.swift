import UIKit
import Firebase

class LoginViewController: UIViewController, UINavigationControllerDelegate {
    
    var loggedInUser: User? = nil
    
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
        view.applyBackgroundGradient()
    }
    
    private func setupView() {
        imageView.image = UIImage(named: "ghost")
        
        titleLabel.text = "Costume Party!"
        titleLabel.font = UIFont.h1
        titleLabel.textColor = UIColor.white.darkerColor()
        
        usernameTextField.placeholder = "Email..."
        passwordTextField.placeholder = "Password..."
        passwordTextField.isSecureTextEntry = true
        
        loginButton.primaryColor = .primaryButtonColor
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.addTarget(self, action: #selector(userTappedLogin), for: .touchUpInside)
        
        registerButton.setTitle("REGISTER", for: .normal)
        
        authorLabel.text = "By Lane Faison"
        authorLabel.font = UIFont.h5
        authorLabel.textColor = UIColor.lighterGrey
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
                lobbyVC.user = self.loggedInUser
                self.navigationController?.pushViewController(lobbyVC, animated: true)
            }
        }
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
                guard let firebaseUser = user else { return }
                Database.database().reference().child("users").child(firebaseUser.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    guard let email = value?["email"] as? String,
                        let costume = value?["costume"] as? String,
                        let userTypeString = value?["userType"] as? String else { return }
                    
                    let userType: UserType = userTypeString == "host" ? .host : .guest
                    self.loggedInUser = User(email: email, costume: costume, userType: userType)
                    completion(true)
                }, withCancel: { (error) in
                    AlertHelper.fireErrorActionSheet(viewController: self, message: error.localizedDescription)
                })
            }
        }
    }
}
