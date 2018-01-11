import UIKit

class LobbyViewController: UIViewController {
    
    let user = FirebaseService.firebaseUser()
    
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
