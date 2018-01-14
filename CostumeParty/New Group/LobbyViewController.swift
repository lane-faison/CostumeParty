import UIKit
import Firebase

class LobbyViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var currentPartyButton: PrimaryButton!
    @IBOutlet weak var findPartyButton: PrimaryButton!
    @IBOutlet weak var hostPartyButton: PrimaryButton!
    @IBOutlet weak var settingsButton: PrimaryButton!

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
        findPartyButton.addTarget(self, action: #selector(goToPartyList), for: .touchUpInside)
        findPartyButton.primaryColor = .secondaryColor
        
        hostPartyButton.setTitle("HOST A PARTY", for: .normal)
        hostPartyButton.addTarget(self, action: #selector(goToHostParty), for: .touchUpInside)
        hostPartyButton.primaryColor = UIColor.secondaryColor.darkerColor()
        
        settingsButton.setTitle("SETTINGS", for: .normal)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButton.primaryColor = .secondaryDarkColor
    }
}

extension LobbyViewController {
    
    @objc func goToPartyList() {
        performSegue(withIdentifier: "toPartyList", sender: self)
    }
    
    @objc func goToHostParty() {
        performSegue(withIdentifier: "toHostParty", sender: self)
    }
    
    @objc func goToSettings() {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
}
