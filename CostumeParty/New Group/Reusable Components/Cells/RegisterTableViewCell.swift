import UIKit

class RegisterTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "RegisterTableViewCell"
        }
    }
    
    @IBOutlet weak var sectionTextField: CredentialsTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
