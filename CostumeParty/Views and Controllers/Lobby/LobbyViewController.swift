import UIKit

class LobbyViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Guest Mode"
        label.text = user?.costume ?? "nothing"
        label2.text = user?.userType.rawValue ?? "nothing"
    }
}
