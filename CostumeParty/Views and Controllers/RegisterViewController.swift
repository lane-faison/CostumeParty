import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var formComplete: Bool = true
    
    fileprivate var userFields = [FieldInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setupTableView()
        
        title = "Registration"
        
        setupView()
        
        // User Text Fields
        let emailField = FieldInfo(title: "Email...", section: .defaultField)
        let passwordField = FieldInfo(title: "Password...", section: .password)
        let confirmField = FieldInfo(title: "Confirm password...", section: .confirmPassword)
        
        // Text Field Arrays
        userFields = [emailField, passwordField, confirmField]
        
        // Registering the different tableView cell types
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userFields.count + 1 // 1 extra for the Submit button cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastIndex = userFields.count
        
        if indexPath.row < lastIndex {
            let cell: RegisterTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
            
            cell.sectionTextField.fieldInfo = userFields[indexPath.row]
            
            if let fieldInfo = cell.sectionTextField.fieldInfo {
                if fieldInfo.section == .password || fieldInfo.section == .confirmPassword {
                    cell.sectionTextField.isSecureTextEntry = true
                }
            }
            
            return cell
        } else {
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            
            cell.delegate = self
            cell.button.setTitle("SUBMIT", for: .normal)
            cell.button.setTitleColor(.secondaryTextColor, for: .normal)
            
            return cell
        }
    }
}

extension RegisterViewController: PrimaryButtonDelegate {
    func buttonTapped() {
        view.endEditing(true)
        checkFields()
    }
}

extension RegisterViewController {
    private func setupView() {
        view.applyPrimaryBackgroundGradient()
    }
    
    private func checkFields() {
        let numberOfRows = userFields.count
        var errorCount: Int = 0
        
        var emailCell = RegisterTableViewCell()
        var passwordCell = RegisterTableViewCell()
        var confirmCell = RegisterTableViewCell()
        
        for row in 0 ..< numberOfRows {
            let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? RegisterTableViewCell
            if cell?.sectionTextField.text?.isEmpty ?? false {
                errorCount += 1
            }
            
            if let fieldInfo = cell?.sectionTextField.fieldInfo {
                guard let cell = cell else {
                    let message = "There was an error when submitting your information. Please try again."
                    AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                    return
                }
                
                switch fieldInfo.section {
                case .password:
                    passwordCell = cell
                case .confirmPassword:
                    confirmCell = cell
                default:
                    emailCell = cell
                }
            }
        }

        if errorCount == 0 {
            guard let email = emailCell.sectionTextField.text,
                let password = passwordCell.sectionTextField.text,
                let confirmPassword = confirmCell.sectionTextField.text else {
                    let message = "There is an error within your information. Please try again."
                    AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                    return
            }
            
            if password == confirmPassword {
                FirebaseService.createUser(viewController: self, email: email, password: password)
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
