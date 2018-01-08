import UIKit

class GuestViewController: UIViewController {
    
    var guest: User?
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Guest Mode"
        label.text = guest?.costume ?? "nothing"
    }
}
