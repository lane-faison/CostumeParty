import UIKit

class LobbyViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var currentPartyButton: PrimaryButton!
    @IBOutlet weak var findPartyButton: PrimaryButton!
    @IBOutlet weak var hostSettingsButton: PrimaryButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        currentPartyButton.setTitle("CURRENT PARTY", for: .normal)
        findPartyButton.setTitle("FIND PARTY", for: .normal)
        hostSettingsButton.setTitle("HOST SETTINGS", for: .normal)
        
        if user?.userType != .host {
            hostSettingsButton.removeFromSuperview()
        }
    }
}
