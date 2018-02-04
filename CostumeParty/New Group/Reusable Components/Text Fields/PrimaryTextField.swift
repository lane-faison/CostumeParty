import UIKit

class PrimaryTextField: UITextField, UITextFieldDelegate {
    
    private let textFieldBackgroundColor: UIColor = .lightTextColor
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        delegate = self
        setupTextField()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        setupTextField()
    }
    
    private func setupTextField(){
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 0.0
        self.autocorrectionType = .default
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
}
