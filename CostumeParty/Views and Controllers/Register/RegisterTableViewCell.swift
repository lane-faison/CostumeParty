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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
