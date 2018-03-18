import UIKit
import Firebase
import AVFoundation
import AudioToolbox

class RootViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: PrimaryTextField!
    @IBOutlet weak var passwordTextField: PrimaryTextField!
    @IBOutlet weak var loginButton: PrimaryButton!
    @IBOutlet weak var registerButton: PrimaryButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var developerButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
    
    @objc func userTappedLogin() {
        activityIndicator.startAnimating()
        
        guard let email = usernameTextField.text,
            let password = passwordTextField.text else { return }
        
        userLogin(email: email, password: password) { [weak self] success in
            guard let strongSelf = self else { return }
            
            defer { strongSelf.activityIndicator.stopAnimating() }
            
            if success {
                // TODO: uncomment this for sound on login: AudioServicesPlayAlertSound(SystemSoundID(1103))
                let lobbyVC = LobbyViewController(nibName: StoryboardName.lobby.rawValue, bundle: nil)
                strongSelf.navigationController?.pushViewController(lobbyVC, animated: true)
            }
        }
    }
    
    @objc func userTappedRegister() {
        let registerFormVC = RegisterFormViewController(nibName: StoryboardName.registerForm.rawValue, bundle: nil)
        navigationController?.pushViewController(registerFormVC, animated: true)
    }
}

extension RootViewController {
    private func userLogin(email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil, let error = error {
                self.activityIndicator.stopAnimating()
                AlertHelper.fireErrorActionSheet(viewController: self, message: error.localizedDescription)
                return
            } else {
                completion(true)
            }
        }
    }
}

extension RootViewController {
    private func setupView() {
        imageView.image = UIImage(named: "ghost")
        
        titleLabel.text = "My Event"
        titleLabel.font = UIFont.h2
        titleLabel.textColor = .darkTextColor
        
        usernameTextField.fieldLabel.text = "Email"
        usernameTextField.returnKeyType = .next
        usernameTextField.tag = 0
        
        passwordTextField.fieldLabel.text = "Password"
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tag = 1
        
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.addTarget(self, action: #selector(userTappedLogin), for: .touchUpInside)
        loginButton.primaryColor = .affirmativeColor
        loginButton.setTitleColor(.lightTextColor, for: .normal)
        
        registerButton.setTitle("SIGN UP", for: .normal)
        registerButton.addTarget(self, action: #selector(userTappedRegister), for: .touchUpInside)
        registerButton.primaryColor = .linkColor
        registerButton.setTitleColor(.lightTextColor, for: .normal)
        
        authorLabel.text = "By Lane Faison"
        authorLabel.font = UIFont.h5
        authorLabel.textColor = .darkTextColor
        
        developerButton.addTarget(self, action: #selector(addDevCredentials), for: .touchUpInside)
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    @objc private func addDevCredentials() {
        usernameTextField.text = "lane1@gmail.com"
        passwordTextField.text = "111111"
        developerButton.isEnabled = false
    }
}
