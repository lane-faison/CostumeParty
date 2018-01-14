import UIKit

protocol PrimaryButtonDelegate: class {
    func buttonTapped()
}
class ButtonTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        get {
            return "ButtonTableViewCell"
        }
    }
    
    @IBOutlet weak var button: PrimaryButton!
    
    weak var delegate: PrimaryButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func buttonTapped(_ sender: PrimaryButton) {
        delegate?.buttonTapped()
    }
}
