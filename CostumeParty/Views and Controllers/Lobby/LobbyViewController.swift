import UIKit

class LobbyViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Lobby"
        
        print(user?.costume)
        print(user?.email)
        print(user?.userType.rawValue)
    }
}
