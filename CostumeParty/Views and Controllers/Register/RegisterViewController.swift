import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var adminMode: Bool = false
    var formComplete: Bool = true

    var guestFields = ["Costume...", "Username...", "Password...", "Confirm password..."]
    var adminFields = ["Party name...", "5-digit party zip code...", "Your costume...", "Username...", "Password...", "Confirm password..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setupTableView()
        
        // Registering the different tableView cell types
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminMode ? 7 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastIndex = adminMode ? 6 : 4
        
        if indexPath.row < lastIndex {
            let cell: RegisterTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
            
            if adminMode {
                cell.sectionTextField.placeholder = adminFields[indexPath.row]
                // For entering the zip code
                if indexPath.row == 1 {
                    cell.sectionTextField.keyboardType = UIKeyboardType.numberPad
                }
            } else {
                cell.sectionTextField.placeholder = guestFields[indexPath.row]
            }
            
            if indexPath.row == lastIndex - 1 || indexPath.row == lastIndex - 2 {
                cell.sectionTextField.securedField = true
            }
            
            return cell
        } else {
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            
            cell.delegate = self
            cell.button.setTitle("Submit", for: .normal)
            
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
    func setupView() {
        //
    }
    
    func checkFields() {
        let numberOfRows = tableView(tableView, numberOfRowsInSection: 0) // minus one because of the Submit button
        var errorCount: Int = 0
        for row in 0 ..< numberOfRows {
            let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? RegisterTableViewCell
            if cell?.sectionTextField.text?.isEmpty ?? false {
                errorCount += 1
            }
        }

        // Fires a zip code error if the user has entered in a zip code but it is not 5-digits long
        if adminMode, let cell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as? RegisterTableViewCell {
            if let zipCode = cell.sectionTextField.text {
                if !zipCode.isEmpty && zipCode.count != 5 {
                    fireZipCodeErrorActionSheet()
                    return
                }
            }
        }
        
        let emailCell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as? RegisterTableViewCell
        let passwordCell = tableView.cellForRow(at: NSIndexPath(row: 2, section: 0) as IndexPath) as? RegisterTableViewCell
        
        if errorCount == 0, let email = emailCell?.sectionTextField.text, let password = passwordCell?.sectionTextField.text {
            createUser(email: email, password: password)
        } else {
            fireMainErrorActionSheet(emptySections: errorCount)
        }
    }
    
    private func fireSuccessActionSheet() {
        let actionSheet = UIAlertController(title: "Success!", message: "Your account has been created! Tap \"Dismiss\" to go log in.", preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.navigationController?.popToRootViewController(animated: true)
        }
        actionSheet.addAction(dismiss)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    private func fireMainErrorActionSheet(emptySections count: Int) {
        let actionSheet = UIAlertController(title: "Error", message: "There are \(count) fields left for you to complete before registering!", preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        actionSheet.addAction(dismiss)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func fireZipCodeErrorActionSheet() {
        let actionSheet = UIAlertController(title: "Zip code error", message: "Please enter in a proper 5-digit zip code", preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        actionSheet.addAction(dismiss)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            
            if error != nil {
                print("Error creating user: \(error!)")
            } else {
                guard let user = user else { return }
                Database.database().reference().child("users").child(user.uid).child("email").setValue(user.email)
                strongSelf.fireSuccessActionSheet()
            }
        }
    }
}
