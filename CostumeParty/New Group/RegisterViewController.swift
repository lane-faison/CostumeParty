import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var userFields = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setupTableView()
        
        title = "Registration"
        userFields = ["Email...", "Password...", "Confirm password..."]
        
        // Registering the different tableView cell types
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        
        setupViewController()
        setupView()
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
            cell.sectionTextField.placeholder = userFields[indexPath.row]
            cell.tag = indexPath.row
            
            if cell.tag == 1 || cell.tag == 2 {
                cell.sectionTextField.isSecureTextEntry = true
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
        
        for row in 0 ..< numberOfRows {
            let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? RegisterTableViewCell
            if cell?.sectionTextField.text?.isEmpty ?? false {
                errorCount += 1
            }
        }
        
        if errorCount == 0 {
            let emailCell = tableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! RegisterTableViewCell
            let passwordCell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as! RegisterTableViewCell
            let confirmPasswordCell = tableView.cellForRow(at: NSIndexPath(row: 2, section: 0) as IndexPath) as! RegisterTableViewCell
            
            guard let email = emailCell.sectionTextField.text,
                let password = passwordCell.sectionTextField.text,
                let confirmPassword = confirmPasswordCell.sectionTextField.text else {
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
