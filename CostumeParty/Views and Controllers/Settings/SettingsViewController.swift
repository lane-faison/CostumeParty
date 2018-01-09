import UIKit

class SettingsViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var logoutButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyBackgroundGradient()
        setupView()
    }
}

extension SettingsViewController {
    private func setupView() {
        logoutButton.primaryColor = .secondaryColor
        logoutButton.setTitle("LOG OUT", for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc private func logout() {
        guard let user = user else { return }
        FirebaseAuthHelper.logout(viewController: self, user: user)
    }
}
