import UIKit

public enum FormSection: String {
    case defaultField
    case password
    case confirmPassword
}

public struct FieldInfo {
    var title: String
    var section: FormSection
}

class PrimaryTextField: UITextField, UITextFieldDelegate {
    
    var fieldInfo: FieldInfo? {
        didSet {
            setupWithFieldInfo(fieldInfo: fieldInfo)
        }
    }
    
    var securedField: Bool = false {
        didSet {
            self.isSecureTextEntry = securedField
        }
    }
    
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
    
    func setupWithFieldInfo(fieldInfo: FieldInfo?) {
        guard let fieldInfo = fieldInfo else { return }
        
        self.placeholder = fieldInfo.title
    }
    
    private func setupTextField(){
        self.layer.cornerRadius = 5.0
        backgroundColor = UIColor.white.darkerColor()
        self.autocorrectionType = .no
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundColor = UIColor.white
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        backgroundColor = UIColor.white.darkerColor()
    }
    
    // User presses Return key
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
