import UIKit

class CredentialsTextField: UITextField, UITextFieldDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
