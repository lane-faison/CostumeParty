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
        setupViewController()
    }
}

extension LobbyViewController {
    
    @objc func goToPartyList() {
        let partyListVC = PartyListViewController(nibName: StoryboardName.partyList.rawValue, bundle: nil)
        navigationController?.pushViewController(partyListVC, animated: true)

    }
    
    @objc func goToHostParty() {
        let hostPartyForm = HostPartyFormViewController(nibName: StoryboardName.hostPartyForm.rawValue, bundle: nil)
        navigationController?.pushViewController(hostPartyForm, animated: true)
    }
    
    @objc func goToSettings() {
        let settingsVC = SettingsViewController(nibName: StoryboardName.settings.rawValue, bundle: nil)
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension LobbyViewController {
    
    private func setupView(user: User) {
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        let name = user.displayName ?? user.email
        if let name = name {
            welcomeLabel.text = "Welcome, \(name)!"
            welcomeLabel.font = .h3
            welcomeLabel.textColor = .darkTextColor
        } else {
            welcomeLabel.text = ""
        }
        
        currentPartyButton.setTitle("CURRENT PARTY", for: .normal)
        currentPartyButton.primaryColor = .linkColor
        
        findPartyButton.setTitle("FIND A PARTY", for: .normal)
        findPartyButton.addTarget(self, action: #selector(goToPartyList), for: .touchUpInside)
        findPartyButton.primaryColor = .linkColor
        
        hostPartyButton.setTitle("HOST A PARTY", for: .normal)
        hostPartyButton.addTarget(self, action: #selector(goToHostParty), for: .touchUpInside)
        hostPartyButton.primaryColor = UIColor.linkColor
        
        settingsButton.setTitle("SETTINGS", for: .normal)
        settingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButton.primaryColor = .linkColor
    }
}

