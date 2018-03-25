import UIKit

protocol EventCellDelegate {
    func userTappedJoin(event: Event)
}

class EventTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "EventTableViewCell"
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            setNeedsLayout()
        }
    }
    
    var event: Event? {
        didSet {
            eventLabel.text = event?.name
            let eventDate = event?.date
            eventDateLabel.text = DateHelper.convertDateToStringForDisplay(date: eventDate)
        }
    }
    
    var delegate: EventCellDelegate?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var eventIcon: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.clipsToBounds = true
        eventLabel.numberOfLines = 0
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.cornerRadius = view.bounds.height * 0.05
        
        eventIcon.contentMode = .scaleAspectFit
        eventIcon.image = iconImage
        
        joinButton.setTitle("Join Event", for: .normal)
        joinButton.setTitleColor(UIColor.lightTextColor, for: .normal)
        joinButton.backgroundColor = UIColor.affirmativeColor
        joinButton.clipsToBounds = true
        joinButton.addTarget(self, action: #selector(userTappedJoinEvent), for: .touchUpInside)
    }
    
    @objc func userTappedJoinEvent() {
        guard let event = event else { return }
        delegate?.userTappedJoin(event: event)
    }
}
