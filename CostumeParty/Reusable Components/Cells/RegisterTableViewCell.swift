import UIKit

class RegisterTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionTextField: PrimaryTextField!
    
    class var reuseIdentifier: String {
        get {
            return "RegisterTableViewCell"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionLabel.textColor = UIColor.primaryTextColor
    }
}
