import UIKit

class RegisterMenuViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "I would like to register as a party..."
            titleLabel.font = UIFont.h3
        }
    }
    @IBOutlet weak var registerAsGuestButton: PrimaryButton! {
        didSet {
            registerAsGuestButton.setTitle("Guest", for: .normal)
        }
    }
    
    @IBOutlet weak var registerAsAdminButton: PrimaryButton! {
        didSet {
            registerAsAdminButton.setTitle("Admin", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Made it to the registration menu")
    }
    

}
