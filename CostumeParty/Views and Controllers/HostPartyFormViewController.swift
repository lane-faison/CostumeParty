import UIKit

class HostPartyFormViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var hostFields = [FieldInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Default fields
        let partyNameField = FieldInfo(title: "Party name...", section: .email)
        let partyZipCodeField = FieldInfo(title: "Party zip code...", section: .email)
        
        hostFields = [partyNameField, partyZipCodeField]
        
        let textFieldNib = UINib(nibName: "RegisterTableViewCell", bundle: nil)
        let buttonNib = UINib(nibName: "ButtonTableViewCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: RegisterTableViewCell.reuseIdentifier)
        tableView.register(buttonNib, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
    }
}

extension HostPartyFormViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegisterTableViewCell.reuseIdentifier) as! RegisterTableViewCell
        
        cell.sectionTextField.fieldInfo = hostFields[indexPath.row]
        return cell
    }
}
