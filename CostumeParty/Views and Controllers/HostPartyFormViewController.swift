import UIKit

class HostPartyFormViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let user = FirebaseService.firebaseUser()
    
    fileprivate var hostFields = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        hostFields = ["Party name...", "Party zip code..."]
        
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
            
            cell.sectionTextField.placeholder = hostFields[indexPath.row]
            cell.tag = indexPath.row
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier) as! ButtonTableViewCell
            
            cell.delegate = self
            cell.button.setTitle("NEXT", for: .normal)
            cell.button.setTitleColor(.secondaryTextColor, for: .normal)
            cell.tag = indexPath.row
            
            return cell
        }
    }
}

extension HostPartyFormViewController: PrimaryButtonDelegate {
    func buttonTapped() {
        performSegue(withIdentifier: "toCategories", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategories" {
            if let destination = segue.destination as? CategoriesViewController {
                
                let nameCell = tableView.cellForRow(at: NSIndexPath(item: 0, section: 0) as IndexPath) as! RegisterTableViewCell
                let zipcodeCell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as! RegisterTableViewCell
                
                guard let partyName = nameCell.sectionTextField.text,
                    let partyZipcodeString = zipcodeCell.sectionTextField.text,
                    let zipcode = Int(partyZipcodeString),
                    let id = user?.uid else { return }
                
                let party = Party(name: partyName, zipCode: zipcode, hostId: id)
                destination.party = party
            }
        }
    }
}
