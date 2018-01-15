import UIKit

class HostPartyFormViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var partyNameField: PrimaryTextField!
    @IBOutlet weak var zipcodeField: PrimaryTextField!
    @IBOutlet weak var nextButton: PrimaryButton!
    
    let user = FirebaseService.firebaseUser()
    
    fileprivate var hostFields = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hostFields = ["Party name...", "Party ZIP Code..."]
        
        view.applyPrimaryBackgroundGradient()
        setupViewController()
        setupView()
    }
}

extension HostPartyFormViewController: PrimaryButtonDelegate {
    @objc func buttonTapped() {
        guard let name = partyNameField.text,
            let zipcode = zipcodeField.text else { return }
        
        // Returns a string of only numbers
        let zipNumbersOnly = zipcode.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if zipcode.count != 5 || zipcode.count != zipNumbersOnly.count {
            let alert = UIAlertController(title: "ZIP Code error", message: "Please enter a valid 5-digit ZIP Code", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            
            present(alert, animated: true, completion: nil)
        } else if !name.isEmpty && !zipcode.isEmpty {
            performSegue(withIdentifier: "toCategories", sender: self)
        } else {
            let alert = UIAlertController(title: "Error", message: "You must complete the form before proceeding.", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategories" {
            if let destination = segue.destination as? CategoriesViewController {
                
                guard let partyName = partyNameField.text,
                    let partyZipcodeString = zipcodeField.text,
                    let zipcode = Int(partyZipcodeString),
                    let id = user?.uid else { return }
                
                let party = Party(name: partyName, zipCode: zipcode, hostId: id)
                destination.party = party
            }
        }
    }
}

extension HostPartyFormViewController {
    private func setupView() {
        headingLabel.font = .h2
        headingLabel.text = "First, enter in some basic information about your party to better help your guests find it!"
        headingLabel.textColor = .primaryTextColor
        
        partyNameField.placeholder = "Party's name..."
        
        zipcodeField.keyboardType = .numberPad
        zipcodeField.placeholder = "Party location's ZIP Code..."
        
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.setTitleColor(.secondaryTextColor, for: .normal)
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
