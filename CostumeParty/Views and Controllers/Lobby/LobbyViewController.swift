import UIKit

class LobbyViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var currentPartyButton: PrimaryButton!
    @IBOutlet weak var findPartyButton: PrimaryButton!
    @IBOutlet weak var hostSettingsButton: PrimaryButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        view.applyBackgroundGradient()
    }
    
    private func setupView() {
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        currentPartyButton.setTitle("CURRENT PARTY", for: .normal)
        currentPartyButton.primaryColor = .secondaryLightColor

        findPartyButton.setTitle("FIND PARTY", for: .normal)
        findPartyButton.primaryColor = .secondaryColor

        let settingsTitle = user?.userType == .host ? "HOST SETTINGS" : "GUEST SETTINGS"
        hostSettingsButton.setTitle(settingsTitle, for: .normal)
        hostSettingsButton.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        hostSettingsButton.primaryColor = .secondaryDarkColor
    }
}

extension LobbyViewController {
    @objc func goToSettings() {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }  
        
        switch identifier {
        case "toSettings":
            guard let destination = segue.destination as? SettingsViewController else { return }
            destination.user = user
        default:
            break
        }
    }
}
