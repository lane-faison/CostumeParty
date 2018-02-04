import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: PrimaryTextField!
    @IBOutlet weak var passwordTextField: PrimaryTextField!
    @IBOutlet weak var confirmTextField: PrimaryTextField!
    @IBOutlet weak var submitButton: PrimaryButton!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    fileprivate var userFields = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Registration"
        
        setupViewController()
        setupView()
    }
}

extension RegisterViewController {
    @objc func buttonTapped() {
        checkFields()
    }
}

extension RegisterViewController {
    private func checkFields() {
        var errorCount: Int = 0
        let textFields: [UITextField] = [emailTextField, passwordTextField, confirmTextField]
        
        for textField in textFields {
            if textField.text?.isEmpty ?? false {
                errorCount += 1
            }
        }
        
        if errorCount == 0 {
            guard let email = emailTextField.text,
                let password = passwordTextField.text,
                let confirmPassword = confirmTextField.text else {
                    let message = "There is an error within your information. Please try again."
                    AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                    return
            }
            
            if password.count < 6  {
                AlertHelper.fireErrorActionSheet(viewController: self, message: "Password must be at least 6 characters long.")
                return
            } else if password == confirmPassword {
                activityIndicator.startAnimating()
                FirebaseService.createUser(viewController: self, email: email, password: password) {
                    self.activityIndicator.stopAnimating()
                }
            } else {
                let message = "Passwords do not match. Please try again."
                AlertHelper.fireErrorActionSheet(viewController: self, message: message)
            }
        } else {
            let message = "You have \(errorCount) section(s) left to complete!"
            AlertHelper.fireErrorActionSheet(viewController: self, message: message)
        }
    }
}

extension RegisterViewController {
    private func setupView() {
        emailTextField.fieldLabel.text = "Email"
        emailTextField.returnKeyType = .next
        emailTextField.tag = 0
        
        passwordTextField.fieldLabel.text = "Password"
        passwordTextField.returnKeyType = .next
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tag = 1
        
        confirmTextField.fieldLabel.text = "Confirm password"
        confirmTextField.returnKeyType = .done
        confirmTextField.isSecureTextEntry = true
        confirmTextField.tag = 2
        
        submitButton.primaryColor = .affirmativeColor
        submitButton.setTitle("SIGN UP!", for: .normal)
        submitButton.setTitleColor(.lightTextColor, for: .normal)
        submitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}
