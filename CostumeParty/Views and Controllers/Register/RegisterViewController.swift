import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: PrimaryButton!
    
    var adminMode: Bool = false
    let standardErrorMessage: String = "Please complete all RED fields"

    var guestFields = ["Costume:", "Username:", "Password:", "Confirm password:"]
    var adminFields = ["Party name:", "Party zip code:", "Your costume:", "Username:", "Password:", "Confirm password:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RegisterTableViewCell")
    }
    
    @IBAction func submitButtonTapped(_ sender: PrimaryButton) {
        print("SUBMIT TAPPED!")
        view.endEditing(true)
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminMode ? 6 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
}

extension RegisterViewController {
    func setupView() {
        submitButton.setTitle("Submit", for: .normal)
    }
    
    func checkFields() {
        //
    }
}
