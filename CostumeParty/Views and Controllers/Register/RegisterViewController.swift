import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var adminMode: Bool = false
    var formComplete: Bool = false

    var guestFields = ["Costume:", "Username:", "Password:", "Confirm password:"]
    var adminFields = ["Party name:", "Party zip code:", "Your costume:", "Username:", "Password:", "Confirm password:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Registering the different tableView cell types
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: "RegisterTableViewCell")
        tableView.register(buttonNib, forCellReuseIdentifier: "ButtonTableViewCell")
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminMode ? 7 : 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highestIndex = adminMode ? 6 : 4
        
        if indexPath.row < highestIndex {
            let cell: RegisterTableViewCell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
            
            if adminMode {
                cell.sectionLabel.text = adminFields[indexPath.row]
                
                // For entering the zip code
                if indexPath.row == 1 {
                    cell.sectionTextField.keyboardType = UIKeyboardType.numberPad
                }
            } else {
                cell.sectionLabel.text = guestFields[indexPath.row]
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
        if formComplete {
            fireSuccessActionSheet()
        } else {
            fireErrorActionSheet()
        }
    }
    
    func fireSuccessActionSheet() {
        let actionSheet = UIAlertController(title: "Error", message: "You must complete all fields in order to submit your registration", preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        actionSheet.addAction(dismiss)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func fireErrorActionSheet() {
        let actionSheet = UIAlertController(title: "Error", message: "You must complete all fields in order to submit your registration", preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        actionSheet.addAction(dismiss)
        
        present(actionSheet, animated: true, completion: nil)
    }
}
