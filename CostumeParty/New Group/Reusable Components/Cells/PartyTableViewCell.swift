import UIKit

class PartyTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "PartyTableViewCell"
        }
    }
    
    @IBOutlet weak var partyIcon: UIImageView!
    @IBOutlet weak var partyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        partyIcon.layer.cornerRadius = 10
    }


    
}
