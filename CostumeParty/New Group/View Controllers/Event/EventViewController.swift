import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var event: Event?
    
    override func viewDidLoad() {
        
        if let event = event {
            name.text = event.name
            date.text = "\(event.date)"
        }
        
        setupViewController()
    }
}
