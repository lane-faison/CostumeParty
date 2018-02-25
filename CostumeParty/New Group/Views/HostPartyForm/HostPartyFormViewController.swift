import UIKit

class HostPartyFormViewController: UIViewController {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var partyNameField: PrimaryTextField!
    @IBOutlet weak var zipcodeField: PrimaryTextField!
    @IBOutlet weak var pinField: PrimaryTextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateButton: PrimaryButton!
    @IBOutlet weak var nextButton: PrimaryButton!
    
    let user = FirebaseService.firebaseUser()
    
    var partyDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
}

extension HostPartyFormViewController {
    @objc func dateButtonTapped() {
        nextButton.isEnabled = true
    }
    
    @objc func nextButtonTapped() {
        guard let name = partyNameField.text,
            let zipcode = zipcodeField.text,
            let pin = pinField.text else { return }
        
        // Returns a string of only numbers
        let zipNumbersOnly = zipcode.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        let pinNumbersOnly = pin.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if zipcode.count != 5 || zipcode.count != zipNumbersOnly.count {
            let alert = UIAlertController(title: "ZIP Code error", message: "Please enter a valid 5-digit ZIP Code", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            
            present(alert, animated: true, completion: nil)
        } else if pin.count != 4 || pin.count != pinNumbersOnly.count {
            let alert = UIAlertController(title: "Pin error", message: "Please enter a valid 4-digit pin", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            
            present(alert, animated: true, completion: nil)
        } else if !name.isEmpty && !zipcode.isEmpty && !pin.isEmpty {
            guard let partyName = partyNameField.text,
                let partyZipcodeString = zipcodeField.text,
                let zipcode = Int(partyZipcodeString),
                let pinString = pinField.text,
                let pin = Int(pinString),
                let id = user?.uid else { return }
            
            let party = Party(name: partyName, zipCode: zipcode, hostId: id, date: partyDate, pin: pin)
            let categoryFormVC = CategoryFormViewController(nibName: StoryboardName.categoryForm.rawValue, bundle: nil)
            categoryFormVC.party = party
            
            navigationController?.pushViewController(categoryFormVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "You must complete the form before proceeding.", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            
            present(alert, animated: true, completion: nil)
        }
    }
}

extension HostPartyFormViewController {
    private func setupView() {
        headingLabel.font = .h4
        headingLabel.text = "First, enter in some basic information to better help your guests find your party!"
        headingLabel.textColor = .darkTextColor
        
        partyNameField.fieldLabel.text = "Party name"
        partyNameField.returnKeyType = .next
        partyNameField.tag = 0
        
        zipcodeField.fieldLabel.text = "Party zip code"
        zipcodeField.keyboardType = .numberPad
        zipcodeField.returnKeyType = .next
        zipcodeField.tag = 1
        
        pinField.fieldLabel.text = "Secret 4-digit pin"
        pinField.keyboardType = .numberPad
        pinField.tag = 2
        
        dateLabel.font = .h4
        dateLabel.text = "No date has been set yet"
        
        dateButton.setTitle("SET DATE", for: .normal)
        dateButton.setTitleColor(.lightTextColor, for: .normal)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.setTitleColor(.lightTextColor, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.isEnabled = false
    }
}
