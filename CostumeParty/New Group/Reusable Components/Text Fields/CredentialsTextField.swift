import UIKit

class CredentialsTextField: UITextField, UITextFieldDelegate {
    
    private let textFieldBackgroundColor: UIColor = .lightTextColor
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        delegate = self
        setupDisplay()
        setupKeyboard()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        setupDisplay()
        setupKeyboard()
    }
    
    private func setupDisplay() {
        backgroundColor = textFieldBackgroundColor.darkerColor().darkerColor()
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    
    private func setupKeyboard() {
        self.autocorrectionType = .no
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundColor = textFieldBackgroundColor.darkerColor()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundColor = textFieldBackgroundColor.darkerColor().darkerColor()
    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setPlaceholderText(_ placeholderTxt: String) {
        
        attributedPlaceholder = NSAttributedString(string: placeholderTxt, attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkTextColor.darkerColor()])
        textColor = .darkTextColor
        
        layoutSubviews()
    }
}
