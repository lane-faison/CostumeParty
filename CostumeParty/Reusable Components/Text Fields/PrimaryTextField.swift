import UIKit

class PrimaryTextField: UITextField, UITextFieldDelegate {
    
    let unhilightedBorderWidth: CGFloat = 1.0
    let hilightedBorderWidth: CGFloat = 2.0
    let standardBorderColor: CGColor = UIColor.lighterGrey.cgColor
    let errorBorderColor: CGColor = UIColor.red.cgColor
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        createBorder()
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        createBorder()
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
    }
    func createBorder(){
        self.layer.borderColor = standardBorderColor
        self.layer.borderWidth = unhilightedBorderWidth
        self.layer.cornerRadius = 5.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderWidth = hilightedBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderWidth = unhilightedBorderWidth
        self.layer.borderColor = self.text?.isEmpty ?? false ? errorBorderColor : standardBorderColor
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let characterCount = textField.text?.count ?? 0
        let doesContainText: Bool = characterCount > 0
        self.layer.borderColor = doesContainText ? standardBorderColor : errorBorderColor
    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
