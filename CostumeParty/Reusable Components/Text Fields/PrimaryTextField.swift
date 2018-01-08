import UIKit

class PrimaryTextField: UITextField, UITextFieldDelegate {
    
    var fieldInfo: FieldInfo? {
        didSet {
            setupWithFieldInfo(fieldInfo: fieldInfo)
        }
    }
    
    let unhilightedBorderWidth: CGFloat = 1.0
    let hilightedBorderWidth: CGFloat = 2.0
    let standardBorderColor: CGColor = UIColor.primaryLightColor.cgColor
    let errorBorderColor: CGColor = UIColor.red.cgColor
    var securedField: Bool = false {
        didSet {
            self.isSecureTextEntry = securedField
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        createBorder()
        setupKeyboard()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        createBorder()
        setupKeyboard()
    }
    
    func setupWithFieldInfo(fieldInfo: FieldInfo?) {
        guard let fieldInfo = fieldInfo else { return }
        
        self.placeholder = fieldInfo.title
    }
    
    private func createBorder(){
        self.layer.borderColor = standardBorderColor
        self.layer.borderWidth = unhilightedBorderWidth
        self.layer.cornerRadius = 5.0
    }
    
    private func setupKeyboard() {
        self.autocorrectionType = .no
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderWidth = hilightedBorderWidth
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderWidth = unhilightedBorderWidth
    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
