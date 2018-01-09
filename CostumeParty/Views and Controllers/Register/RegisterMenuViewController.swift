import UIKit

class RegisterMenuViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerAsGuestButton: PrimaryButton!
    @IBOutlet weak var registerAsAdminButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        view.applyBackgroundGradient()
        setupView()
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

extension RegisterMenuViewController {
    private func setupView() {
        titleLabel.text = "I am a party..."
        titleLabel.font = UIFont.h3
        
        registerAsGuestButton.setTitle("GUEST", for: .normal)
        registerAsGuestButton.primaryColor = .secondaryLightColor
        
        registerAsAdminButton.setTitle("HOST", for: .normal)
        registerAsAdminButton.primaryColor = .secondaryColor
    }
}
