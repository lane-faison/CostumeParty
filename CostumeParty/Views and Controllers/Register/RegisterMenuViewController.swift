import UIKit

class RegisterMenuViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "I am a..."
            titleLabel.font = UIFont.h3
        }
    }
    @IBOutlet weak var registerAsGuestButton: PrimaryButton! {
        didSet {
            registerAsGuestButton.setTitle("Party Guest!", for: .normal)
        }
    }
    
    @IBOutlet weak var registerAsAdminButton: PrimaryButton! {
        didSet {
            registerAsAdminButton.setTitle("Party Host!", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! RegisterViewController

        if segue.identifier == "goToGuestRegistration" {
            controller.adminMode = false
        }
        if segue.identifier == "goToAdminRegistration" {
            controller.adminMode = true
        }
    }
    
    @IBAction func guestButtonTapped(_ sender: PrimaryButton) {
        performSegue(withIdentifier: "goToGuestRegistration", sender: nil)
    }
    
    @IBAction func adminButtonTapped(_ sender: PrimaryButton) {
        performSegue(withIdentifier: "goToAdminRegistration", sender: nil)
    }
}
