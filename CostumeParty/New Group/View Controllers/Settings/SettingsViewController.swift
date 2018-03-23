import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        setupViewController()
        setupView()
    }
}

extension SettingsViewController {
    
    @objc private func logout() {
        AlertHelper.fireCancelOrActionAlert(viewContoller: self, title: "Log Out", message: "Are you sure you want to log out?", okayTitle: "Log Out") {
            FirebaseService.logout(viewController: self, completion: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
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

