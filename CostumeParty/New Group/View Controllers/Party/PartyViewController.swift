import UIKit

class PartyViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var party: Party?
    
    override func viewDidLoad() {
        
        if let party = party {
            name.text = party.name
            date.text = "\(party.date)"
        }
        
        setupViewController()
    }
}
