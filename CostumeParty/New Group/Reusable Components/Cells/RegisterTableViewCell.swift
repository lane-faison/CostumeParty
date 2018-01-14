import UIKit

class RegisterTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "RegisterTableViewCell"
        }
    }
    
    @IBOutlet weak var sectionTextField: PrimaryTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
