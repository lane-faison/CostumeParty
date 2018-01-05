import UIKit

protocol PrimaryButtonDelegate: class {
    func buttonTapped()
}
class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: PrimaryButton!
    
    class var reuseIdentifier: String {
        get {
            return "ButtonTableViewCell"
        }
    }
    
    weak var delegate: PrimaryButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func buttonTapped(_ sender: PrimaryButton) {
        delegate?.buttonTapped()
    }
}
