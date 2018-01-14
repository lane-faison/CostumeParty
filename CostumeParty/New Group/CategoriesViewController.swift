import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    
    var party: Party?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyPrimaryBackgroundGradient()
        setupView()
    }
}

extension CategoriesViewController {
    private func setupView() {
        headingLabel.font = .h2
        headingLabel.text = "Next, add some costume categories for your party!"
        headingLabel.textColor = .primaryTextColor
    }
    
    private func submitTapped() {
        //    guard let user = user else { return }
        //    
        //    let nameCell = tableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as? RegisterTableViewCell
        //    let zipcodeCell = tableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as? RegisterTableViewCell
        //    
        //    guard let name = nameCell?.sectionTextField.text, let zipcodeString = zipcodeCell?.sectionTextField.text else { return }
        //    
        //    if let zipcode = Int(zipcodeString) {
        //    let party = Party(name: name, zipCode: zipcode, hostId: user.uid)
        //    
        //    FirebaseService.createParty(viewController: self, party: party)
    }
}
