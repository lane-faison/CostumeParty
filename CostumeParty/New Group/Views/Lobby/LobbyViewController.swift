import UIKit
import Firebase

class LobbyViewController: UIViewController {
    
    @IBOutlet weak var currentPartyButtonView: LargeButtonView!
    @IBOutlet weak var findPartyButtonView: LargeButtonView!
    @IBOutlet weak var hostPartyButtonView: LargeButtonView!
    @IBOutlet weak var settingsButtonView: LargeButtonView!
    
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
        
        currentPartyButtonView.mainLabel.text = "Enter current party"
        currentPartyButtonView.primaryColor = UIColor.linkColor
        
        findPartyButtonView.mainLabel.text = "Search for a party"
        findPartyButtonView.mainButton.addTarget(self, action: #selector(goToPartyList), for: .touchUpInside)
        findPartyButtonView.primaryColor = UIColor.affirmativeColor
        
        
        hostPartyButtonView.mainLabel.text = "Host a party"
        hostPartyButtonView.mainButton.addTarget(self, action: #selector(goToHostParty), for: .touchUpInside)
        hostPartyButtonView.primaryColor = UIColor.destructiveColor
        
        settingsButtonView.mainLabel.text = "Settings"
        settingsButtonView.mainButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        settingsButtonView.primaryColor = UIColor.inactiveColor
    }
}

