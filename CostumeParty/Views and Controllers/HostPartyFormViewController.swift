import UIKit

class HostPartyFormViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let user = FirebaseService.firebaseUser()
    
    fileprivate var hostFields = [FieldInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Default fields
        let partyNameField = FieldInfo(title: "Party name...", section: .defaultField)
        let partyZipCodeField = FieldInfo(title: "Party zip code...", section: .defaultField)
        
        hostFields = [partyNameField, partyZipCodeField]
        
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        
        view.applyPrimaryBackgroundGradient()
    }
}

extension HostPartyFormViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostFields.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < hostFields.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
            
            cell.sectionTextField.fieldInfo = hostFields[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            
            cell.delegate = self
            cell.button.setTitle("NEXT", for: .normal)
            cell.button.setTitleColor(.secondaryTextColor, for: .normal)
            
            return cell
        }
    }
}

extension HostPartyFormViewController: PrimaryButtonDelegate {
    func buttonTapped() {
        print("SUBMIT TAPPED")
        guard let user = user else { return }
        
        let nameCell = tableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as? RegisterTableViewCell
        let zipcodeCell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as? RegisterTableViewCell
        
        guard let name = nameCell?.sectionTextField.text, let zipcodeString = zipcodeCell?.sectionTextField.text else { return }
        
        if let zipcode = Int(zipcodeString) {
            let party = Party(name: name, zipCode: zipcode, hostId: user.uid)
            
            FirebaseService.createParty(viewController: self, party: party)
        }
    }
    
    
}
