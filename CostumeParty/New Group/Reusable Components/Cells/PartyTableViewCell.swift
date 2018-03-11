import UIKit

class PartyTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "PartyTableViewCell"
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBOutlet weak var partyIcon: UIImageView!
    @IBOutlet weak var partyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        partyIcon.contentMode = .scaleAspectFit
        partyIcon.image = iconImage
    }
}
