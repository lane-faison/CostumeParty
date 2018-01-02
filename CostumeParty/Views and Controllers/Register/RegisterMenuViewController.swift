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

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! RegistrationViewController

        if segue.identifier == "goToGuestRegistration" {
            controller.guestMode = true
        }
        if segue.identifier == "goToAdminRegistration" {
            controller.guestMode = false
        }
    }
    
    @IBAction func guestButtonTapped(_ sender: PrimaryButton) {
        performSegue(withIdentifier: "goToGuestRegistration", sender: nil)
    }
    
    @IBAction func adminButtonTapped(_ sender: PrimaryButton) {
        performSegue(withIdentifier: "goToAdminRegistration", sender: nil)
    }
    

}
