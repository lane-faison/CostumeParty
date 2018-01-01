import UIKit

class PrimaryTextField: UITextField, UITextFieldDelegate {
    
    let unhilightedBorderWidth: CGFloat = 1.0
    let hilightedBorderWidth: CGFloat = 2.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        createBorder()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        createBorder()
    }
    func createBorder(){
        self.layer.borderColor = UIColor.lighterGrey.cgColor
        self.layer.borderWidth = unhilightedBorderWidth
        self.layer.cornerRadius = 5.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderWidth = hilightedBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderWidth = unhilightedBorderWidth
        
        if self.text?.isEmpty ?? false {
            self.layer.borderColor = UIColor.red.cgColor
        } else {
            self.layer.borderColor = UIColor.green.cgColor
        }
    }    
}
