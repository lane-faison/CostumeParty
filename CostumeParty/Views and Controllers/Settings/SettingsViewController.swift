import UIKit

class SettingsViewController: UIViewController {
        
    @IBOutlet weak var logoutButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.applyPrimaryBackgroundGradient()
        setupView()
    }
}

extension SettingsViewController {
    private func setupView() {
        logoutButton.primaryColor = .secondaryColor
        logoutButton.setTitle("LOG OUT", for: .normal)
        logoutButton.setTitleColor(.primaryTextColor, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc private func logout() {
        FirebaseService.logout(viewController: self)
    }
}
