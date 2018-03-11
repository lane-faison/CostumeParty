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
    
    var party: Party? {
        didSet {
            partyLabel.text = party?.name
            let partyDate = party?.date
            partyDateLabel.text = DateHelper.convertDateToStringForDisplay(date: partyDate)
        }
    }
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var partyIcon: UIImageView!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.cornerRadius = view.bounds.height * 0.05
        partyIcon.contentMode = .scaleAspectFit
        partyIcon.image = iconImage
        joinButton.setTitle("Join Event", for: .normal)
        joinButton.setTitleColor(UIColor.darkTextColor, for: .normal)
        joinButton.backgroundColor = UIColor.primaryColor
        joinButton.clipsToBounds = true
    }
}
