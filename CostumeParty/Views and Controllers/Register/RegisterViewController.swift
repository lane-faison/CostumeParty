import UIKit

enum FormSection {
    case partyName
    case partyZipCode
    case costume
    case email
    case password
    case confirmPassword
}

public struct FieldInfo {
    var title: String
    var section: FormSection
    var forUserType: UserType
    
    init(title: String, section: FormSection, forUserType: UserType) {
        self.title = title
        self.section = section
        self.forUserType = forUserType
    }
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var adminMode: Bool = false
    var formComplete: Bool = true
    
    fileprivate var hostFields = [FieldInfo]()
    fileprivate var guestFields = [FieldInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setupTableView()
        
        title = adminMode ? "Host Registration" : "Guest Registration"
        
        setupView()
        
        // Host Text Fields
        let partyNameField = FieldInfo(title: "Party name...", section: .partyName, forUserType: .host)
        let partyZipCodeField = FieldInfo(title: "Zip code...", section: .partyZipCode, forUserType: .host)
        let hostCostumeField = FieldInfo(title: "Costume description...", section: .costume, forUserType: .host)
        let hostEmailField = FieldInfo(title: "Email...", section: .email, forUserType: .host)
        let hostPasswordField = FieldInfo(title: "Password...", section: .password, forUserType: .host)
        let hostConfirmField = FieldInfo(title: "Confirm password...", section: .confirmPassword, forUserType: .host)
        
        // Guest Text Fields
        let guestCostumeField = FieldInfo(title: "Costume description...", section: .costume, forUserType: .guest)
        let guestEmailField = FieldInfo(title: "Email...", section: .email, forUserType: .guest)
        let guestPasswordField = FieldInfo(title: "Password...", section: .password, forUserType: .guest)
        let guestConfirmField = FieldInfo(title: "Confirm password...", section: .confirmPassword, forUserType: .guest)
        
        // Text Field Arrays
        hostFields = [partyNameField, partyZipCodeField, hostCostumeField, hostEmailField, hostPasswordField, hostConfirmField]
        guestFields = [guestCostumeField, guestEmailField, guestPasswordField, guestConfirmField]
        
        // Registering the different tableView cell types
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalTextFields = adminMode ? hostFields.count : guestFields.count
        return totalTextFields + 1 // 1 extra for the Submit button cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastIndex = adminMode ? hostFields.count : guestFields.count
        
        if indexPath.row < lastIndex {
            let cell: RegisterTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
            
            if adminMode {
                cell.sectionTextField.fieldInfo = hostFields[indexPath.row]
            } else {
                cell.sectionTextField.fieldInfo = guestFields[indexPath.row]
            }
            
            if let fieldInfo = cell.sectionTextField.fieldInfo {
                if fieldInfo.section == .password || fieldInfo.section == .confirmPassword {
                    cell.sectionTextField.isSecureTextEntry = true
                }
                if fieldInfo.section == .partyZipCode {
                    cell.sectionTextField.keyboardType = UIKeyboardType.numberPad
                }
            }
            return cell
        } else {
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            
            cell.delegate = self
            cell.button.setTitle("SUBMIT", for: .normal)
            
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
        view.applyBackgroundGradient()
    }
    
    private func checkFields() {
        let numberOfRows = adminMode ? hostFields.count : guestFields.count
        var errorCount: Int = 0
        
        var partyNameCell = RegisterTableViewCell()
        var partyZipCodeCell = RegisterTableViewCell()
        var costumeCell = RegisterTableViewCell()
        var emailCell = RegisterTableViewCell()
        var passwordCell = RegisterTableViewCell()
        var confirmCell = RegisterTableViewCell()
        
        for row in 0 ..< numberOfRows {
            let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: 0) as IndexPath) as? RegisterTableViewCell
            if cell?.sectionTextField.text?.isEmpty ?? false {
                errorCount += 1
            }
            
            // Fires a zip code error if the user has entered in a zip code but it is not 5-digits long
            if let fieldInfo = cell?.sectionTextField.fieldInfo, fieldInfo.section == .partyZipCode, let fieldText = cell?.sectionTextField.text {
                if !fieldText.isEmpty && fieldText.count != 5 {
                    let title = "Format Error"
                    let message = "Please enter in a proper 5-digit zip code!"
                    AlertHelper.fireErrorActionSheet(viewController: self, title: title, message: message)
                    return
                }
            }
            
            if let fieldInfo = cell?.sectionTextField.fieldInfo {
                guard let cell = cell else {
                    let message = "There was an error when submitting your information. Please try again."
                    AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                    return
                }
                
                switch fieldInfo.section {
                case .partyName:
                    partyNameCell = cell
                case .partyZipCode:
                    partyZipCodeCell = cell
                case .costume:
                    costumeCell = cell
                case .email:
                    emailCell = cell
                case .password:
                    passwordCell = cell
                case .confirmPassword:
                    confirmCell = cell
                }
            }
        }

        if errorCount == 0 {
            guard let costume = costumeCell.sectionTextField.text,
                let email = emailCell.sectionTextField.text,
                let password = passwordCell.sectionTextField.text,
                let confirmPassword = confirmCell.sectionTextField.text else {
                    let message = "There is an error within your information. Please try again."
                    AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                    return
            }
            
            let userType: UserType = adminMode ? .host : .guest
            let user = User(email: email, costume: costume, userType: userType)
            
            if password == confirmPassword {
                if adminMode {
                    guard let partyName = partyNameCell.sectionTextField.text,
                        let partyZipCode = partyZipCodeCell.sectionTextField.text else {
                            let message = "There is an error within your party's information. Please try again."
                            AlertHelper.fireErrorActionSheet(viewController: self, message: message)
                            return
                    }
                    
                    let party = Party(name: partyName, zipCode: Int(partyZipCode)!, host: user)
                    FirebaseAuthHelper.createUser(viewController: self, user: user, password: password, party: party)
                } else {
                    FirebaseAuthHelper.createUser(viewController: self, user: user, password: password)
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
