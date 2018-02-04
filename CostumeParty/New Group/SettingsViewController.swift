import UIKit

class SettingsViewController: UIViewController {
        
    @IBOutlet weak var logoutButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupView()
    }
}

extension SettingsViewController {
    
    @objc private func logout() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Log Out", style: .default) { _ in
            FirebaseService.logout(viewController: self)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okay)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController {
    private func setupView() {
        logoutButton.primaryColor = .inactiveColor
        logoutButton.setTitle("LOG OUT", for: .normal)
        logoutButton.setTitleColor(.darkTextColor, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
}
