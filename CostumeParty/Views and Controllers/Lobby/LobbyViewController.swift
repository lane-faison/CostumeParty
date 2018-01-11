import UIKit
import Firebase

class LobbyViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var currentPartyButton: PrimaryButton!
    @IBOutlet weak var findPartyButton: PrimaryButton!
    @IBOutlet weak var hostSettingsButton: PrimaryButton!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        guard let user = FirebaseService.firebaseUser() else { return }
        
        setupView(user: user)
        view.applyPrimaryBackgroundGradient()
    }
    
    private func setupView(user: User) {
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        let name = user.displayName ?? user.email
        if let name = name {
            welcomeLabel.text = "Welcome, \(name)!"
            welcomeLabel.font = .h2
            welcomeLabel.textColor = .primaryTextColor
        } else {
            welcomeLabel.text = ""
        }
        
        currentPartyButton.setTitle("CURRENT PARTY", for: .normal)
        currentPartyButton.primaryColor = .secondaryLightColor

        findPartyButton.setTitle("FIND A PARTY", for: .normal)
        findPartyButton.primaryColor = .secondaryColor
        
        hostSettingsButton.setTitle("SETTINGS", for: .normal)
        hostSettingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        hostSettingsButton.primaryColor = .secondaryDarkColor
    }
}

extension LobbyViewController {
    @objc func goToSettings() {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
}
