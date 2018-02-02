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
        backgroundColor = textFieldBackgroundColor.darkerColor()
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    
    private func setupKeyboard() {
        self.autocorrectionType = .no
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        textField.backgroundColor = self.textFieldBackgroundColor
                        textField.layer.borderWidth = 1.0
                        textField.layer.borderColor = UIColor.darkTextColor.cgColor
        },
                       completion: { Void in()  }
        )
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        textField.backgroundColor = self.textFieldBackgroundColor.darkerColor()
                        textField.layer.borderWidth = 0.0
        },
                       completion: { Void in()  }
        )
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
